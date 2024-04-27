enum EnumResponseCurrentState{
  yes,
  no,
  undefined,
  repeat,
  login,
  course,
  training,
  chatAssistant,
  myVocabulary,
  profile,
  inHospital,
  inTaxi,
  inRestaurant,
  inInterview,
  inHotel,
  firstDate,
  backToHomePage
}

extension EnumResponseCurrentStateExtension on EnumResponseCurrentState {
  String serverType() {
    switch (this) {
      case EnumResponseCurrentState.yes:
        return 'YES';
      case EnumResponseCurrentState.no:
        return 'NO';
      case EnumResponseCurrentState.undefined:
        return 'UNDEFINED';
      case EnumResponseCurrentState.repeat:
        return 'REPEAT';
      case EnumResponseCurrentState.login:
        return 'LOGIN';
      case EnumResponseCurrentState.course:
        return 'COURSE';
      case EnumResponseCurrentState.training:
        return 'TRAINING';
      case EnumResponseCurrentState.chatAssistant:
        return 'CHAT_ASSISTANT';
      case EnumResponseCurrentState.myVocabulary:
        return 'MY_VOCABULARY';
      case EnumResponseCurrentState.profile:
        return 'PROFILE';
      case EnumResponseCurrentState.inHospital:
        return 'IN_HOSPITAL';
      case EnumResponseCurrentState.inTaxi:
        return 'IN_TAXI';
      case EnumResponseCurrentState.inRestaurant:
        return 'IN_RESTAURANT';
      case EnumResponseCurrentState.inInterview:
        return 'IN_INTERVIEW';
      case EnumResponseCurrentState.inHotel:
        return 'IN_HOTEL';
      case EnumResponseCurrentState.firstDate:
        return 'FIRST_DATE';
      case EnumResponseCurrentState.backToHomePage:
        return 'BACK_TO_HOME_PAGE';
    }
  }
// ChatType getChatType(String type) {
//   switch (type) {
//     case 'IN_HOSPITAL':
//       return ChatType.hospital;
//   }
// }
}