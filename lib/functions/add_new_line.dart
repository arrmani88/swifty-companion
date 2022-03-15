addNewLine(List list) {
  for(String string in list) {
    for(int i = 0; i < string.length; i++) {
      string.replaceAll(' ', '\n');
    }
  }
}