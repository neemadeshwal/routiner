import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';

class Step1Gender extends StatefulWidget{

  const Step1Gender({super.key});

  @override
  State<Step1Gender> createState() => _Step1GenderState();
}

class _Step1GenderState extends State<Step1Gender> {
  @override
  Widget build(BuildContext context){
    final state=context.watch<UserSetupBloc>().state;
    final savedGender=state is UserSetupProgress? state.formData.gender : state is UserSetupSubmitting ? state.formData.gender : null;
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:20),

        Text("What is your gender?", style: AppTextStyles.appBarTitle),
        SizedBox(height:20),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: AppDimensions.paddingLG,
          crossAxisSpacing: AppDimensions.paddingLG,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            genderCard(label: 'Male', icon: Icons.male,savedGender: savedGender??""),
            genderCard(label: 'Female', icon: Icons.female,savedGender: savedGender??""),
            genderCard(label: 'Others', icon: Icons.transgender,savedGender: savedGender??""),
            genderCard(label: 'Prefer not to say', icon: Icons.help_outline,savedGender: savedGender??""),
          ],
        ),

      ],
    );
  }

  Widget genderCard({required String label, required IconData icon,required String savedGender}) {
    final isSelected = savedGender == label;
    return GestureDetector(
      onTap: () {
      context.read<UserSetupBloc>().add(UserSetupGenderSelected(gender:label));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}