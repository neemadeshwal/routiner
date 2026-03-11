import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.go(RouteConstants.signin);
        }
      },
      child: Scaffold(
        body: Center(
          child: CustomButton(
            text: "Log out",
            onPressed: () => context.read<AuthBloc>().add(SignOutRequested()),
          ),
        ),
      ),
    );
  }
}
