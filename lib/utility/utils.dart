

class Utils {
 

  static setPngPath(String name) {
    return 'assets/images/$name.png';
  }
  static setGifPath(String name) {
    return 'assets/images/$name.gif';
  }


static String capitalize(String value) {
  var result = value[0].toUpperCase();
  bool cap = true;
  for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
            result = result + value[i];
            cap = false;
      }
  }
  return result;
}

  
}