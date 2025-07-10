import 'package:another_flushbar/flushbar.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/services_offered.dart'; // Assuming HomePage is here
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RateReviewDialog extends StatefulWidget {
  final String cleanerEmail;
  final String cleanerName;

  const RateReviewDialog({
    super.key,
    required this.cleanerEmail,
    required this.cleanerName,
  });

  @override
  State<RateReviewDialog> createState() => _RateReviewDialogState();
}

class _RateReviewDialogState extends State<RateReviewDialog> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a rating')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You must be logged in to submit a review')),
      );
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    try {
      // Add review to Firestore
      await FirebaseFirestore.instance.collection('cleanerReview').add({
        'cleaner_email': widget.cleanerEmail,
        'cleaner_name': widget.cleanerName,
        'user_id': currentUser.uid,
        'rating': _rating,
        'review': _reviewController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Get all reviews to calculate average
      final querySnapshot = await FirebaseFirestore.instance
          .collection('cleanerReview')
          .where('cleaner_email', isEqualTo: widget.cleanerEmail)
          .get();

      double total = 0;
      final count = querySnapshot.docs.length;

      for (var doc in querySnapshot.docs) {
        final ratingValue = doc['rating'];
        if (ratingValue is num) {
          total += ratingValue.toDouble();
        }
      }

      final average = count > 0 ? total / count : 0.0;

      // Save average rating to another collection
      await FirebaseFirestore.instance
          .collection('cleanerRating')
          .doc(widget.cleanerEmail)
          .set({
        'average_rating': average,
        'cleaner_email': widget.cleanerEmail,
        'cleaner_name': widget.cleanerName,
        'total_reviews': count,
      });

      // Show success message
      await Flushbar(
        messageText: const Text(
          "Thank you for sharing your review with us!",
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.kSuccessMessageColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'Helvetica Neue',
          ),
        ),
        backgroundColor: AppTheme.kSuccessColor,
        boxShadows: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(0, 4.5),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        flushbarPosition: FlushbarPosition.TOP,
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 400),
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeIn,
        isDismissible: true,
        padding: const EdgeInsets.all(16),
      ).show(context);

      if (!mounted) return;

      // Navigate to HomePage (adjust import if HomePage is elsewhere)
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        return IconButton(
          icon: Icon(
            starIndex <= _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 36,
          ),
          onPressed: () {
            setState(() {
              _rating = starIndex.toDouble();
            });
          },
          splashRadius: 24,
          tooltip: '$starIndex star${starIndex > 1 ? 's' : ''}',
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Rate & Review ${widget.cleanerName}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please rate and review your cleaner',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            _buildStarRating(),
            const SizedBox(height: 12),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Write your review here',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (_isSubmitting)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CircularProgressIndicator(),
          )
        else ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitReview,
            child: const Text('Submit'),
          ),
        ],
      ],
    );
  }
}