import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/recommend.dart';
import 'package:coffee_admin/src/data/remote/response/recommend/recommend_response.dart';
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_bloc.dart';
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/tag.dart';
import '../../login/widgets/custom_button.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../../tag/screen/tag_page.dart';
import '../bloc/add_recommend_event.dart';

class AddRecommendPage extends StatelessWidget {
  const AddRecommendPage({Key? key, this.recommend, required this.onChange})
      : super(key: key);

  final RecommendResponse? recommend;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddRecommendBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.addRecommend,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: AddRecommendView(onChange: onChange, recommend: recommend),
      ),
    );
  }
}

class AddRecommendView extends StatefulWidget {
  const AddRecommendView({Key? key, required this.onChange, this.recommend})
      : super(key: key);

  final RecommendResponse? recommend;
  final VoidCallback onChange;

  @override
  State<AddRecommendView> createState() => _AddRecommendViewState();
}

class _AddRecommendViewState extends State<AddRecommendView> {
  TextEditingController minTempController = TextEditingController();
  TextEditingController maxTempController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Tag> listTag = [];
  String weather = "CLOUDS";
  List<Map<String, dynamic>> listWeather = [
    {"name": "CLOUDS", "image": AppImages.imgClouds},
    {"name": "RAIN", "image": AppImages.imgRain},
    {"name": "SNOW", "image": AppImages.imgSnow},
    {"name": "CLEAR", "image": AppImages.imgClear},
  ];

  @override
  void initState() {
    if (widget.recommend != null) {
      minTempController.text = (widget.recommend!.minTemp ?? "").toString();
      maxTempController.text = (widget.recommend!.maxTemp ?? "").toString();
      weather = widget.recommend!.weather!;
      listTag.addAll(
          widget.recommend!.tags!.map((e) => Tag.fromTagResponse(e)).toList());
    }
    minTempController.addListener(() => checkEmpty());
    maxTempController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (maxTempController.text.isNotEmpty ||
        minTempController.text.isNotEmpty) {
      context.read<AddRecommendBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddRecommendBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    maxTempController.dispose();
    minTempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkEmpty();
    return BlocListener<AddRecommendBloc, AddRecommendState>(
      listener: (context, state) {
        if (state is AddRecommendSuccess) {
          widget.onChange();
          if (widget.recommend == null) {
            customToast(
                context, AppLocalizations.of(context)!.addSuccessfulRecommend);
          } else {
            customToast(
                context, AppLocalizations.of(context)!.updateSuccessful);
          }
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddRecommendLoading) {
          loadingAnimation(context);
        }
        if (state is AddRecommendError) {
          Navigator.pop(context);
          customToast(context, state.status);
        }
        if (state is ChangeTagState || state is ChangeWeatherState) {
          checkEmpty();
        }
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.weather),
              const SizedBox(height: 10),
              pickWeather(),
              const SizedBox(height: 10),
              descriptionLine(
                  text: AppLocalizations.of(context)!.lowestTemperature),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: minTempController,
                hint: "20°C",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.lowestTemperature}";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z-.]")),
                ],
              ),
              const SizedBox(height: 10),
              descriptionLine(
                  text: AppLocalizations.of(context)!.maximumTemperature),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: maxTempController,
                hint: "30°C",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.maximumTemperature}";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z-.]")),
                ],
              ),
              const SizedBox(height: 10),
              addTag(),
              const SizedBox(height: 10),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickWeather() {
    return BlocBuilder<AddRecommendBloc, AddRecommendState>(
      buildWhen: (previous, current) => current is ChangeWeatherState,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.borderColor, width: 0.7),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              hint: Text(
                AppLocalizations.of(context)!.weather,
                style: const TextStyle(fontSize: 16),
              ),
              items: listWeather
                  .map((item) => DropdownMenuItem<String>(
                        value: item["name"].toString(),
                        child: Row(
                          children: [
                            Image.asset(item["image"], width: 30),
                            const SizedBox(width: 10),
                            Text(
                              item["name"].toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              value: weather,
              onChanged: (value) {
                weather = value!;
                context.read<AddRecommendBloc>().add(ChangeWeatherEvent());
              },
              dropdownStyleData: const DropdownStyleData(maxHeight: 250),
            ),
          ),
        );
      },
    );
  }

  Widget addTag() {
    return Column(
      children: [
        Row(
          children: [
            descriptionLine(text: AppLocalizations.of(context)!.addTags),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: TagPage(
                    listTag: listTag.map((e) => e.tagId!).toList(),
                    onPick: (list) {
                      listTag = list;
                      context.read<AddRecommendBloc>().add(ChangeTagEvent());
                    },
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              child: Text(AppLocalizations.of(context)!.add),
            )
          ],
        ),
        BlocBuilder<AddRecommendBloc, AddRecommendState>(
          buildWhen: (previous, current) => current is ChangeTagState,
          builder: (context, state) {
            return listTag.isEmpty
                ? Text(
                    AppLocalizations.of(context)!.noTags,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.statusBarColor,
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listTag.length,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, index) {
                      String color =
                          "FF${listTag[index].tagColorCode!.split("#").last}";
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(int.parse(color, radix: 16)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "${listTag[index].tagName!} - ${listTag[index].tagColorCode!}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  listTag.removeAt(index);
                                  context
                                      .read<AddRecommendBloc>()
                                      .add(ChangeTagEvent());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        )
      ],
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddRecommendBloc, AddRecommendState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.save,
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              if (widget.recommend == null) {
                context
                    .read<AddRecommendBloc>()
                    .add(CreateRecommendEvent(Recommend(
                      weather: weather,
                      tags: listTag,
                      minTemp: minTempController.text.isEmpty
                          ? null
                          : double.parse(minTempController.text),
                      maxTemp: maxTempController.text.isEmpty
                          ? null
                          : double.parse(maxTempController.text),
                    )));
              } else {
                context
                    .read<AddRecommendBloc>()
                    .add(UpdateRecommendEvent(Recommend(
                      id: widget.recommend!.id,
                      weather: weather,
                      tags: listTag,
                      minTemp: minTempController.text.isEmpty
                          ? null
                          : double.parse(minTempController.text),
                      maxTemp: maxTempController.text.isEmpty
                          ? null
                          : double.parse(maxTempController.text),
                    )));
              }
            }
          },
        );
      },
    );
  }
}
