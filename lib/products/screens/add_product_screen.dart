import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/loaders/app_loader.dart';
import 'package:myshop/app/utils/app_colors.dart';
import 'package:myshop/app/utils/validators.dart';
import 'package:myshop/app/widgets/app_button.dart';
import 'package:myshop/app/widgets/app_input.dart';
import 'package:myshop/products/models/adress_model.dart';
import 'package:myshop/products/models/product_model.dart';
import 'package:myshop/products/product_service.dart';
import 'package:multiselect/multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController _productnameController;
  late TextEditingController _prixController;
  late TextEditingController _categorieController;
  late TextEditingController _descriptionController;
  late TextEditingController _villeController;
  late TextEditingController _telephoneController;
  late TextEditingController _whatsAppController;
  late TextEditingController _nameController;
  late DateTime addDate;
  List<String> _imgUrls = [];
  List<File> _images = [];
  final picker = ImagePicker();
  late ProductService _productService;
  User user = FirebaseAuth.instance.currentUser!;
  List<String> categories = [];
  LoaderController _loaderController = AppLoader.bounce();
  File? _localImage;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    _productnameController = TextEditingController();
    _nameController = TextEditingController();
    _categorieController = TextEditingController();
    _descriptionController = TextEditingController();
    _villeController = TextEditingController();
    _telephoneController = TextEditingController();
    _whatsAppController = TextEditingController();
    _prixController = TextEditingController();
    _productService = ProductService();

    super.initState();
  }

  void selectGaleryImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
  }

  void selectCameraImage() async {
    final XFile? selected = await _picker.pickImage(source: ImageSource.camera);
  }

  // Future uploadFile(File? _photo) async {
  //   if (_photo == null) return;
  //   final fileName = basename(_photo.path);
  //   final destination = 'images/$fileName';
  //   final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
  //   var chemin = await ref.putFile(_photo);
  //   return chemin.ref.getDownloadURL();
  // }

  Future<String?> uploadFile(File file) async {
    var task = await FirebaseStorage.instance
        .ref('images/${file.hashCode}')
        .putFile(file);
    return task.ref.getDownloadURL();
  }

  @override
  void dispose() {
    _productnameController.dispose();
    _nameController.dispose();
    _categorieController.dispose();
    _descriptionController.dispose();
    _villeController.dispose();
    _telephoneController.dispose();
    _whatsAppController.dispose();
    _prixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppInput(
                  controller: _productnameController,
                  label: "Product Name",
                  placeholder: "Entrez le nom du produit",
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppInput(
                  controller: _prixController,
                  label: "Price",
                  placeholder: "Prix en FCFA",
                  textInputType: TextInputType.number,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    setState(() {
                      categories = x;
                    });
                  },
                  options: const [
                    "Vehicules",
                    "Immobilier",
                    "Electronique",
                    "Electroniques et ordinateurs",
                    "Telephones mobiles",
                    "Vetements",
                    "Chaussures",
                  ],
                  selectedValues: categories,
                  whenEmpty: 'Categorie',
                ),
                AppInput(
                  controller: _villeController,
                  label: "Ville",
                  placeholder: "Entrer la ville",
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppInput(
                  controller: _nameController,
                  label: "Name",
                  placeholder: "Entrer votre nom",
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppInput(
                  controller: _telephoneController,
                  label: "Phone Number",
                  textInputType: TextInputType.phone,
                  placeholder: "Numero de telephone",
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppInput(
                  controller: _whatsAppController,
                  label: "WhatsApp",
                  placeholder: "WhatsApp",
                  textInputType: TextInputType.phone,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppInput(
                  controller: _descriptionController,
                  label: "Description",
                  placeholder: "Decrivez votre produit",
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: GridView.builder(
                    itemCount: _images.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: IconButton(
                                onPressed: () async {
                                  var result = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context, "camera");
                                            },
                                            minWidth: 40,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.camera,
                                                  color: AppColors.primary,
                                                ),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                      color: AppColors.primary),
                                                ),
                                              ],
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context, "gallery");
                                            },
                                            minWidth: 40,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.file_download,
                                                  color: AppColors.primary,
                                                ),
                                                Text(
                                                  "Galerry",
                                                  style: TextStyle(
                                                      color: AppColors.primary),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  if (result == "camera") {
                                    chooseImageCam();
                                    if (_localImage != null) {
                                      var img = await uploadFile(_localImage!);
                                      _imgUrls.add(img!);
                                      _localImage = null;
                                    }
                                    setState(() {});
                                  }
                                  if (result == "gallery") {
                                    chooseImageGal();

                                    if (_localImage != null) {
                                      var img = await uploadFile(_localImage!);
                                      _imgUrls.add(img!);
                                      _localImage = null;
                                    }
                                    setState(() {});
                                  }
                                  // for (var img in _images) {
                                  //   setState(() {
                                  //     _imgUrls.add(img.path);
                                  //   });
                                  // }
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    _images[index - 1],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                AppButton(
                  title: "Add",
                  onPressed: () async {
                    try {
                      _loaderController.open(context);

                      ProductModel productModel = ProductModel(
                        pname: _productnameController.text,
                        prix: double.parse(_prixController.text),
                        categorie: categories.first,
                        ville: _villeController.text,
                        telephone: _telephoneController.text,
                        name: _nameController.text,
                        whatsApp: _whatsAppController.text,
                        email: user.email!,
                        description: _descriptionController.text,
                        imgUrls: _imgUrls,
                        addDate: DateTime.now(),
                      );
                      await _productService.addProduct(
                        productModel: productModel,
                      );
                      _nameController.clear();
                      _prixController.clear();
                      _productnameController.clear();
                      _descriptionController.clear();
                      _categorieController.clear();
                      _villeController.clear();
                      _telephoneController.clear();
                      _whatsAppController.clear();
                      _telephoneController.clear();
                      setState(() {
                        _loaderController.close();
                        _images.clear();
                      });
                    } catch (e) {
                      _loaderController.close();
                      log(e.toString());
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  chooseImageCam() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _images.add(File(pickedImage!.path));
      _localImage = File(pickedImage.path);
    });

    if (pickedImage!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _images.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  chooseImageGal() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images.add(File(pickedImage!.path));
      _localImage = File(pickedImage.path);
    });

    if (pickedImage!.path == null) retrieveLostData();
  }
}
