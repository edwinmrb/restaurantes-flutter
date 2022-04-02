import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:restaurantes/core/controllers/create_restaurant_controller.dart';
import 'package:restaurantes/core/models/food_type.dart';

class CreateRestaurantPage extends GetView<CreateRestaurantController> {
  const CreateRestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<CreateRestaurantController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(title: const Text("Agregar un restaurante")),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.createRestaurantFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  maxLines: 4,
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                ),
                controller.obx(
                  (List<FoodType>? foodTypes) =>
                      MultiSelectDialogField<FoodType>(
                    items: foodTypes
                            ?.map((FoodType foodType) =>
                                MultiSelectItem(foodType, foodType.name))
                            .toList() ??
                        [],
                    listType: MultiSelectListType.CHIP,
                    cancelText: const Text('Cancelar'),
                    confirmText: const Text('Confirmar'),
                    title: const Text("Tipos de comida"),
                    onConfirm: (List<FoodType> values) =>
                        controller.selectedListFoodType =
                            values.map((e) => e.slug).toList(),
                  ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onError: (error) => Text(
                    'Error: $error',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  onEmpty: const Text('No Restaurants available'),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(color: Colors.red[200]),
                  child: Obx(
                    () => controller.image.value != null
                        ? Image.file(
                            File(controller.image.value!.path),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: BoxDecoration(color: Colors.red[200]),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    controller.getFromGallery();
                  },
                  child: const Text('CARGAR IMAGE'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    controller.saveRestaurant();
                  },
                  child: const Text('AGREGAR RESTAURANTE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}