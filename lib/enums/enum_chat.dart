enum ChatType{
  hospital,
  taxi,
  restaurant,
  interview,
  hotel,
  friend
}

extension ChatTypeExtension on ChatType {
  String serverType() {
    switch (this) {
    case ChatType.hospital:
    return 'IN_HOSPITAL';
    case ChatType.taxi:
    return 'IN_TAXI';
    case ChatType.restaurant:
    return 'IN_RESTAURANT';
    case ChatType.interview:
    return 'IN_INTERVIEW';
    case ChatType.hotel:
    return 'IN_HOTEL';
    case ChatType.friend:
    return 'FIRS_DATE';
    }
  }
  // ChatType getChatType(String type) {
  //   switch (type) {
  //     case 'IN_HOSPITAL':
  //       return ChatType.hospital;
  //   }
  // }
}

