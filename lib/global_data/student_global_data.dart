// ignore_for_file: non_constant_identifier_names

class GlobalStudent {
  static Map<String, dynamic> profiles = {};
  static Map<String, dynamic> specificProfile = {};
  static int? id;
  static String urlPrefix = "https://trusher.shellcode.co.in/";
  static List moveCourse = [];

  updateProfiles(Map<String, dynamic> map) {
    profiles = map;
    print("Global Profiles");
    print(profiles);
  }

  updateId(int ID) {
    id = ID;
    print("Global ID");
    print(id);
  }

  updateSpecificProfile(Map<String, dynamic> map) {
    specificProfile = map;
    print("Global Specific Profiles");
    print(specificProfile);
  }
}
