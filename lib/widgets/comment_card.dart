// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key,required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
  User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18,horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.snap['profilePic']),
          ),
          Expanded(
            child: Padding(padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                  text: widget.snap['name'] +' ',
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),TextSpan(
                  text: widget.snap['text'],
                )
                  ]
                )),
                Padding(padding: EdgeInsets.only(top: 4,),
                child: Text(DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),)
              ],
            ),),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.favorite,size: 16,),
          )
        ],
      ),
    );
  }
}