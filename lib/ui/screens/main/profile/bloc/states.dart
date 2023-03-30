import '../../../../../models/entities/home_entities/home_translator_entity.dart';

enum ProfileViewResponseStatus{init,loading,success,error}

class ProfileTransStates{
 final String?message;
 final List<PublicTranslatorEntity>?transEntities;
 final ProfileViewResponseStatus ?profileViewResponseStatus;

 ProfileTransStates({this.message,this.transEntities,this.profileViewResponseStatus=ProfileViewResponseStatus.init});
 ProfileTransStates.copyWith({this.message,this.transEntities,this.profileViewResponseStatus});
}