import '../../../../../models/entities/home_entities/home_translator_entity.dart';

abstract class  HomeViewStates{}

enum HomeViewResponseStatus{init,loading,success,error}

class GetHomeTranslatorsState extends HomeViewStates{
  final HomeViewResponseStatus ?homeViewResponseStatus;
  final List<PublicTranslatorEntity> ?publicTranslatorsEntity;
  final String?message;

  GetHomeTranslatorsState({this.homeViewResponseStatus=HomeViewResponseStatus.init,this.publicTranslatorsEntity,this.message});

  GetHomeTranslatorsState.copyWith({this.homeViewResponseStatus,this.publicTranslatorsEntity,this.message});


}