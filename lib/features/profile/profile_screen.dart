import 'package:flutter/material.dart';
import 'package:networking_app/core/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:networking_app/models/user_profile.dart';

import 'package:networking_app/models/user_profile.dart';
import 'dart:io';

class ProfileScreenArgs {
  final UserProfile userProfile;

  ProfileScreenArgs({required this.userProfile});
}

class ProfileScreen extends StatefulWidget {
  final ProfileScreenArgs args;
  const ProfileScreen({super.key, required this.args});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _userProfile;

  @override
  void initState() {
    super.initState();
  }
  File? _profileImage;
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _roleController = TextEditingController();
  final _linkController = TextEditingController();
  final List<String> _links = [];
    Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _profileImage = File(returnedImage.path);
    });
  }

    void _saveProfile() {
        // Save profile data and links
        String name = _nameController.text;
        String role = _roleController.text;
        String bio = _bioController.text;
        // _links already contains the list of links
    }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _roleController.dispose();
    _linkController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
        _userProfile = widget.args.userProfile;
        _nameController.text = _userProfile.name;
        _roleController.text = _userProfile.role;
        _bioController.text = _userProfile.bio ?? '';



    return Scaffold(
      appBar: AppBar(title: Text(_userProfile.name)),
      body: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [AppColors.blue, AppColors.lightBlue],
           ),
        ),
        child: SafeArea(
          child: Padding(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                   
                    child: _ProfilePicture(
                      onTap: _pickImageFromGallery,
                      profileImage: _profileImage,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _TextFieldSection(
                      hintText: 'Name',
                      controller: _nameController,                      
                       enabled: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _TextFieldSection(                      
                      hintText: 'Role',
                      controller: _roleController,
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _BioSection(controller: _bioController),
                  ),
                  const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(                      onPressed: _saveProfile,
                   child: const Padding(padding: EdgeInsets.all(10.0),child: Text('Save profile')),
                 ),
                ),                 
                
                _LinksSection(
                      links: _links,
                      controller: _linkController,
                      onLinkDeleted: (link) {}),
                  const SizedBox(height: 20),
                  
                ],
              ),
              
            ),
          ),
        ),
      ), 
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({this.onTap, this.profileImage});
  final void Function()? onTap;
  final File? profileImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: CircleAvatar(
            radius: 75,
            backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
            child: profileImage == null ? const Icon(Icons.person, size: 100, color: AppColors.white,) : null
        ),
      ),
    );
  }
}

class _BioSection extends StatelessWidget {
  const _BioSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(15)),child: Column(children: [
          Padding(
            
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'About me',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            cursorColor: AppColors.black,
            controller: controller,
            maxLines: 5,
           style: const TextStyle(color: AppColors.black),
            
            decoration: InputDecoration(
              hintText: 'Enter your bio',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),),],
        
      ),
    );
  }
}

class _TextFieldSection extends StatelessWidget {
  const _TextFieldSection({required this.hintText, required this.controller, this.enabled});
  final String hintText;
  final TextEditingController controller;
  final bool? enabled;
  @override
  Widget build(BuildContext context) { 
    return TextField(style: const TextStyle(color: AppColors.black),controller: controller,
       cursorColor: AppColors.black,
        decoration: InputDecoration(
           enabled: enabled,
          hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.lightGrey),
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.black)
            
        ),
      ),
    );
  }
}

class _LinksSection extends StatefulWidget {
  const _LinksSection(
      {required this.links, required this.controller, required this.onLinkDeleted});
  final List<String> links;
  final TextEditingController controller;
  final void Function(String link) onLinkDeleted;

  @override
  State<_LinksSection> createState() => _LinksSectionState();
}

class _LinksSectionState extends State<_LinksSection> {
  void _addLink() {
    setState(() {
      widget.links.add(widget.controller.text);
      widget.controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(15)),child: Column(
          
          children: [
            TextField(
              
              controller: widget.controller,
              decoration:  InputDecoration(
                hintText: 'Enter your url',
                hintStyle: const TextStyle(color: AppColors.lightGrey) ,
                  border:  OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: AppColors.black)),
                    suffixIcon: Padding(padding: const EdgeInsets.all(8.0), 
                    child: ElevatedButton(
                      onPressed: _addLink,
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.blue),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
                          )
                        ),                   
                    child:  Icon(Icons.add, color: AppColors.white,),
                    ),
                  
                  )),
            ),
            const SizedBox(height: 10),
            Column(
              children: [for (var link in widget.links)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [                            
                          Expanded(child: Text(link,
                              style: const TextStyle(color: AppColors.black))),
                         Padding(padding: const EdgeInsets.only(left: 10.0),
                         child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.links.remove(link);

                              });
                            },icon:  Icon(

                              Icons.delete,
                              color: AppColors.red,
                            ))
                        ],
                      ),
                    ),                  )
              ],
            ),
            const SizedBox(height: 10),
          ],
        )); 
  }
}