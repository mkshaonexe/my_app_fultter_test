import 'package:flutter/material.dart';
import '../../../domain/models.dart';
import '../../core/app_theme.dart';
import '../features/bank_view_model.dart';

class ProfileView extends StatelessWidget {
  final BankViewModel viewModel;

  const ProfileView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final profile = viewModel.profile;

        return Scaffold(
          backgroundColor: AppColors.lightGray,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 32),
                  _buildAvatarSection(context),
                  const SizedBox(height: 32),
                  _buildPersonalInfoCard(context, profile),
                  const SizedBox(height: 24),
                  _buildAccountInfoCard(context),
                  const SizedBox(height: 100), // Navigation spacing
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const Center(
      child: Text(
        'Profile',
        style: TextStyle(
          color: AppColors.charcoal,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Circular Avatar Wrapper
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 56,
              backgroundColor: AppColors.neonLime,
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                  width: 112,
                  height: 112,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person_rounded,
                      size: 56,
                      color: AppColors.charcoal,
                    );
                  },
                ),
              ),
            ),
          ),
          // Edit Pencil overlay icon
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderLight, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.charcoal.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: AppColors.charcoal,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context, UserProfile profile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Personal info',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              GestureDetector(
                onTap: () => _showEditProfileSheet(context, profile),
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.charcoal,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(context, Icons.person_outline_rounded, 'Name', profile.name),
          const Divider(height: 24, color: AppColors.borderLight),
          _buildInfoRow(context, Icons.mail_outline_rounded, 'E-mail', profile.email),
          const Divider(height: 24, color: AppColors.borderLight),
          _buildInfoRow(context, Icons.phone_outlined, 'Phone number', profile.phone),
          const Divider(height: 24, color: AppColors.borderLight),
          _buildInfoRow(context, Icons.home_outlined, 'Home address', profile.address),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 22),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account info',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          _buildAccountStatusRow('Account Status', 'Active', Colors.green),
          const Divider(height: 24, color: AppColors.borderLight),
          _buildAccountStatusRow('Member Since', 'October 2024', AppColors.charcoal),
          const Divider(height: 24, color: AppColors.borderLight),
          _buildAccountStatusRow('Verification Level', 'Tier 2 (Verified)', AppColors.charcoal),
        ],
      ),
    );
  }

  Widget _buildAccountStatusRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showEditProfileSheet(BuildContext context, UserProfile profile) {
    final nameController = TextEditingController(text: profile.name);
    final emailController = TextEditingController(text: profile.email);
    final phoneController = TextEditingController(text: profile.phone);
    final addressController = TextEditingController(text: profile.address);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField('Full Name', nameController),
              const SizedBox(height: 12),
              _buildTextField('E-mail', emailController),
              const SizedBox(height: 12),
              _buildTextField('Phone number', phoneController),
              const SizedBox(height: 12),
              _buildTextField('Home address', addressController),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  viewModel.updateProfile(
                    UserProfile(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.charcoal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.charcoal, width: 2),
        ),
      ),
      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.charcoal),
    );
  }
}
