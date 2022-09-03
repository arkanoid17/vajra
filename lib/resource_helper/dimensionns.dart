class Dimensions {
  static getScreenWidth(c) {
    return c.MediaQuery.of(c).size.width;
  }

  static getScreenHeight(c) {
    return c.MediaQuery.of(c).size.height;
  }
}
