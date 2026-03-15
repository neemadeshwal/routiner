import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/features/onboarding/domain/entities/user_setup_entities.dart';
import 'package:routiner/features/onboarding/domain/usecases/save_user_setup_usecase.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:routiner/features/onboarding/presentation/bloc/user_setup_state.dart';

class UserSetupBloc extends Bloc<UserSetupEvent, UserSetupState> {
  final SaveUserSetupUsecase saveUserSetupUseCase;

  UserSetupBloc({required this.saveUserSetupUseCase})
      : super(UserSetupProgress(UserSetupEntity(
            userId: '',
            currentStep: 0,
            gender: '',
            dob: null,
            wakeupHour: 7,
            wakeupMinute: 30,
            wakeupIsAm: true,
            reflectionHour: 7,
            reflectionMinute: 10,
            reflectionIsAm: false,
            goals: [],
            firstHabit: '',
            days: {},
            reminder: '',
            duration: ''))) {
    on<UserSetupNextStep>(_onNextStep);
    on<UserSetupPreviousStep>(_onPreviousStep);
    on<UserSetupComplete>(_onCompleted);
    on<UserSetupGenderSelected>(_onGenderSelected);
    on<UserSetupDobSelected>(_onDobSelected);
    on<UserSetupWakeupSelected>(_onWakeupSelected);
    on<UserSetupReflectionSelected>(_onReflectionSelected);
    on<UserSetupGoalsSelected>(_onUserSetupGoalsSelected);
    on<UserSetupFirstHabitSelected>(_onUserSetupFirstHabitSelected);
    on<UserSetupSetGoalSelected>(_onUserSetupSetGoalSelected);
  }

 UserSetupEntity _getData(){
  final state=this.state;
  if(state is UserSetupProgress) return state.formData;
  if(state is UserSetupSubmitting) return state.formData;
  final uid=FirebaseAuth.instance.currentUser?.uid;
  if(uid==null) return const UserSetupEntity(userId: '');
  return  UserSetupEntity(userId: uid);
 }

 void _onNextStep(UserSetupNextStep event, Emitter<UserSetupState> emit) {
  final data = _getData();
  if (data.currentStep >= 6) return;
  emit(UserSetupProgress(data.copyWith(currentStep: data.currentStep + 1)));
 }

 void _onPreviousStep(UserSetupPreviousStep event, Emitter<UserSetupState> emit){
  final data=_getData();
  if(data.currentStep<=0) return;

  emit(UserSetupProgress(data.copyWith(currentStep:data.currentStep-1)));
 }

  Future<void> _onCompleted(
      UserSetupComplete event, Emitter<UserSetupState> emit) async {
    var data = _getData();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (data.userId.isEmpty && uid != null) {
      data = data.copyWith(userId: uid);
    }
    emit(UserSetupSubmitting(data));
    final result = await saveUserSetupUseCase(data);
    result.fold(
      (failure) => emit(UserSetupError(failure.message)),
      (_) => emit(UserSetupSuccess()),
    );
  }

 void _onGenderSelected(UserSetupGenderSelected event, Emitter<UserSetupState>emit){
   emit(UserSetupProgress(_getData().copyWith(gender:event.gender)));
 }
 void _onDobSelected(UserSetupDobSelected event, Emitter<UserSetupState> emit){
  emit(UserSetupProgress(_getData().copyWith(dob:event.dob)));
 }

 void _onWakeupSelected(UserSetupWakeupSelected event, Emitter<UserSetupState> emit){
  emit(UserSetupProgress(_getData().copyWith(wakeupHour:event.hour,wakeupMinute: event.minute,wakeupIsAm: event.isAm)));
 }

 void _onReflectionSelected(UserSetupReflectionSelected event, Emitter<UserSetupState> emit){
  emit(UserSetupProgress(_getData().copyWith(reflectionHour:event.hour,reflectionMinute: event.minute,reflectionIsAm: event.isAm)));
 }
 void _onUserSetupFirstHabitSelected(UserSetupFirstHabitSelected event, Emitter<UserSetupState> emit){
  emit(UserSetupProgress(_getData().copyWith(firstHabit:event.habit)));
 }
 void _onUserSetupSetGoalSelected(UserSetupSetGoalSelected event, Emitter<UserSetupState> emit){
  emit(UserSetupProgress(_getData().copyWith(days:event.days,reminder:event.reminder,duration:event.duration)));
 }
 void _onUserSetupGoalsSelected(UserSetupGoalsSelected event, Emitter<UserSetupState> emit){
  emit(UserSetupProgress(_getData().copyWith(goals:event.goals)));
 }
  
  
}