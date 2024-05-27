import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/widgets/custom_alert_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixit/constants.dart';
import 'package:fixit/widgets/custom_button.dart';

class WriteReviewScreen extends StatefulWidget {
  static String id = 'write_review_screen';
  final String? category;
  final String? email;
  String? comment;

  WriteReviewScreen({Key? key, this.category, this.email}) : super(key: key);

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  File? _image;
  late FocusNode _textFieldFocusNode;
  late double _rating = 0;
  bool _isSubmitting = false;
  String? _userImage;
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode = FocusNode();
    _fetchUserData();
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          _userEmail = user.email;
        });
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_userEmail)
            .get();
        if (userDoc.exists) {
          setState(() {
            _userImage = userDoc.data()?['ImageLink'];
            _userName = userDoc.data()?['FullName'];
          });
        }
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_textFieldFocusNode.hasFocus) {
          _textFieldFocusNode.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: KSurface,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: KSurface,
          title: Text(
            'Write a review',
            style: TextStyle(fontFamily: Kword),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      'Rate This ${widget.category}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: KWhite,
                        fontFamily: Kword,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tell others what you think',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: Kword,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 32,
                    itemPadding: EdgeInsets.symmetric(horizontal: 18),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_border,
                      color: Colors.white,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  focusNode: _textFieldFocusNode,
                  onChanged: (value) {
                    setState(() {
                      widget.comment = value;
                    });
                  },
                  onTap: () {
                    _textFieldFocusNode.requestFocus();
                  },
                  decoration: InputDecoration(
                    hintText: 'Write something...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: Kword,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: KSurface,
                  ),
                  maxLines: 10,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _textFieldFocusNode.unfocus(),
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Upload Your Image',
                  onTap: _getImageFromGallery,
                ),
                SizedBox(height: 190),
                _isSubmitting
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'Submit',
                        onTap: () async {
                          if (_rating == 0) {
                            showCustomDialog(
                                context, 'Please select a rating.');
                            return;
                          }

                          if (widget.comment == null ||
                              widget.comment!.isEmpty) {
                            showCustomDialog(
                                context, 'Please write a comment.');
                            return;
                          }

                          setState(() {
                            _isSubmitting = true;
                          });
                          await _addCommentToFirestore(widget.comment);
                          setState(() {
                            _isSubmitting = false;
                          });
                          Navigator.pop(context);
                        },
                      ),
                CustomButton(
                  text: 'Cancel',
                  primaryColor: KSurface,
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(message: message);
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _addCommentToFirestore(String? comment) async {
    try {
      String? imageUrl;
      if (_image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('review_images/${DateTime.now().millisecondsSinceEpoch}');
        final uploadTask = storageRef.putFile(_image!);
        final snapshot = await uploadTask.whenComplete(() => {});
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      String email = widget.email ?? '';
      String userName = _userName ?? 'Unknown User';
      String userImage = _userImage ?? '';

      await FirebaseFirestore.instance
          .collection('Comments')
          .doc(email)
          .collection('Comment')
          .add({
        'content': comment,
        'rating': _rating,
        'imageUrl': imageUrl,
        'userName': userName,
        'userImage': userImage,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance
          .collection('tradepersons')
          .doc(email)
          .update({
        'ReviewsNumber': FieldValue.increment(1),
        'TotalRating': FieldValue.increment(_rating),
      });

      print('Comment added successfully');
    } catch (error) {
      print('Error adding comment: $error');
    }
  }
}
