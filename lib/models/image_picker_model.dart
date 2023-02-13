class ImagePickerModel {
  String? imageurl;
  String? imagename;
  bool? uploadstate;

  ImagePickerModel({this.imageurl, this.imagename, this.uploadstate});

  ImagePickerModel.fromJson(Map<String, dynamic> json) {
    imageurl = json['imageurl'];
    imagename = json['imagename'];
    uploadstate = json['uploadstate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageurl'] = imageurl;
    data['imagename'] = imagename;
    data['uploadstate'] = uploadstate;
    return data;
  }
}
