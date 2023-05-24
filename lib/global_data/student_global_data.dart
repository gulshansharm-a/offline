// ignore_for_file: non_constant_identifier_names

class GlobalStudent {
  static Map<String, dynamic> profiles = {};
  static Map<String, dynamic> specificProfile = {};
  static Map<String, dynamic> courses = {};
  static Map<String, dynamic> mycourses = {};
  static int? id;
  static String urlPrefix = "https://trusher.shellcode.co.in/";
  static List moveCourse = [];
  static List purchasedCourses = [];

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

  updateCourses(Map<String, dynamic> map) {
    courses = map;
    print("Global Specific Profiles");
    print(courses);
  }

  updateMyCourses(Map<String, dynamic> map) {
    mycourses = map;
    print("Global Specific Profiles");
    print(mycourses);
  }
}
