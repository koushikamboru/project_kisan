// lib/Features/diagnosis/screens/camera_view_screen.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraViewScreen extends StatefulWidget {
  const CameraViewScreen({super.key});

  @override
  State<CameraViewScreen> createState() => _CameraViewScreenState();
}

class _CameraViewScreenState extends State<CameraViewScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  XFile? _capturedImage;

  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _setupCameras();
  }

  Future<void> _setupCameras() async {
    // Get the list of available cameras.
    _cameras = await availableCameras();
    // Initialize the camera with the first camera in the list (usually the back camera).
    await _initializeCamera(_selectedCameraIndex);
  }

  Future<void> _initializeCamera(int cameraIndex) async {
    // If there's an existing controller, dispose of it first.
    if (_controller != null) {
      await _controller!.dispose();
    }

    // Create a new CameraController.
    _controller = CameraController(
      _cameras[cameraIndex],
      ResolutionPreset.high,
    );

    // Initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller!.initialize();

    // Update the state to rebuild the widget with the new camera preview.
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onTakePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      print(e);
    }
  }

  void _onRetakePicture() {
    setState(() {
      _capturedImage = null;
    });
  }

  void _onConfirmPicture() {
    // TODO: Implement logic to use the confirmed image.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image confirmed! Path: ${_capturedImage!.path}')),
    );
  }

  // New function to handle picking an image from the gallery.
  void _onPickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _capturedImage = image;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // New function to handle flipping the camera.
  void _onFlipCamera() {
    if (_cameras.length > 1) {
      // Cycle through the available cameras.
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _initializeCamera(_selectedCameraIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Crop Diagnosis'),
        backgroundColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCameraSection(context),
              const SizedBox(height: 24),
              _buildTipsCard(),
              const SizedBox(height: 24),
              _buildSectionHeader('Recent Diagnoses'),
              const SizedBox(height: 8),
              _buildRecentDiagnosesList(),
              const SizedBox(height: 24),
              _buildSectionHeader('Quick Actions'),
              const SizedBox(height: 16),
              _buildQuickActions(),
              const SizedBox(height: 24),
              _buildSectionHeader('Common Crop Issues'),
              const SizedBox(height: 8),
              _buildCommonIssuesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          children: [
            _capturedImage != null
                ? _buildImagePreview()
                : _buildCameraPreview(),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              color: Colors.grey[200],
              child:
                  _capturedImage != null
                      ? _buildImageControls()
                      : _buildCameraControls(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (_controller == null || !_controller!.value.isInitialized) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(80.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        return CameraPreview(_controller!);
      },
    );
  }

  Widget _buildImagePreview() {
    return Image.file(
      File(_capturedImage!.path),
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  Widget _buildCameraControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.photo_library_outlined, size: 30),
          onPressed: _onPickImageFromGallery, // UPDATED
        ),
        ElevatedButton(
          onPressed: _onTakePicture,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.grey[800],
          ),
          child: const Icon(Icons.camera, color: Colors.white),
        ),
        IconButton(
          icon: const Icon(Icons.flip_camera_ios_outlined, size: 30),
          onPressed: _onFlipCamera, // UPDATED
        ),
      ],
    );
  }

  Widget _buildImageControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text('Retake'),
          onPressed: _onRetakePicture,
          style: TextButton.styleFrom(foregroundColor: Colors.black87),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.check),
          label: const Text('Confirm'),
          onPressed: _onConfirmPicture,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  // ... All other helper widgets (_buildSectionHeader, etc.) remain the same
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                'How to get best results',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildTipRow('Take clear photos of affected leaves or stems'),
          _buildTipRow('Ensure good lighting'),
          _buildTipRow('Focus on the diseased area'),
          _buildTipRow('Include healthy parts for comparison'),
        ],
      ),
    );
  }

  Widget _buildTipRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 4.0),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(color: Colors.black54)),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDiagnosesList() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFE0E0E0),
              child: Text('MD', style: TextStyle(color: Colors.black54)),
            ),
            title: const Text('Tomato Blight'),
            subtitle: const Text('2 hours ago'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFE0E0E0),
              child: Text('WD', style: TextStyle(color: Colors.black54)),
            ),
            title: const Text('Wheat Rust'),
            subtitle: const Text('Yesterday'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: const [
        Expanded(
          child: _QuickActionCard(icon: Icons.mic_none, title: 'Voice Query'),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.menu_book,
            title: 'Disease Guide',
          ),
        ),
      ],
    );
  }

  Widget _buildCommonIssuesList() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.bug_report_outlined),
            title: const Text('Pest Infestation'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.grass_outlined),
            title: const Text('Nutrient Deficiency'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const _QuickActionCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey[700]),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
