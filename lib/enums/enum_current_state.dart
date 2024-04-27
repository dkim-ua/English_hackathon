enum EnumCurrentState{
  voiceAssistantCurrentState,
  courseCurrentState,
  startPageCurrentState,
  selectChatTypeCurrentState
}

extension EnumCurrentStateType on EnumCurrentState {
  String serverType() {
    switch (this) {
      case EnumCurrentState.voiceAssistantCurrentState:
        return 'DO_YOU_NEED_VOICE_ASSISTANT';
      case EnumCurrentState.courseCurrentState:
        return 'COURSE';
      case EnumCurrentState.startPageCurrentState:
        return 'LOGIN_PAGE';
      case EnumCurrentState.selectChatTypeCurrentState:
        return 'SELECT_CHAT_ASSISTANT_THEME';
    }
  }
// ChatType getChatType(String type) {
//   switch (type) {
//     case 'IN_HOSPITAL':
//       return ChatType.hospital;
//   }
// }
}