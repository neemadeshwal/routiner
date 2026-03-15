import 'package:equatable/equatable.dart';

class UserSetupEntity extends Equatable {
  final String userId;
  final int currentStep;
  final String? gender;
  final DateTime? dob;
  final int wakeupHour;
  final int wakeupMinute;
  final bool wakeupIsAm;
  final int reflectionHour;
  final int reflectionMinute;
  final bool reflectionIsAm;
  final List<String> goals;
  final String? firstHabit;
  final Set<String> days;
  final String reminder;
  final String duration;

  const UserSetupEntity({
    required this.userId,
    this.currentStep=0,
    this.gender,
    this.dob,
     this.wakeupHour=7,
  this.wakeupMinute=30,
    this.wakeupIsAm=true,
     this.reflectionHour=7,
     this.reflectionMinute=10,
     this.reflectionIsAm=false,
  this.goals=const[],
    this.firstHabit,
     this.days= const {'Mon','Tue'},
    this.reminder='Morning',
     this.duration='5 min',
  });

  UserSetupEntity copyWith({
    String? userId,
    int? currentStep,
    String? gender,
    DateTime? dob,
    int? wakeupHour,
    int? wakeupMinute,
    bool? wakeupIsAm,
    int? reflectionHour,
    int? reflectionMinute,
    bool? reflectionIsAm,
    List<String>? goals,
    String? firstHabit,
    Set<String>? days,
    String? reminder,
    String? duration,
  }) {
    return UserSetupEntity(
      userId: userId ?? this.userId,
      currentStep: currentStep ?? this.currentStep,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      wakeupHour: wakeupHour ?? this.wakeupHour,
      wakeupMinute: wakeupMinute ?? this.wakeupMinute,
      wakeupIsAm: wakeupIsAm ?? this.wakeupIsAm,
      reflectionHour: reflectionHour ?? this.reflectionHour,
      reflectionMinute: reflectionMinute ?? this.reflectionMinute,
      reflectionIsAm: reflectionIsAm ?? this.reflectionIsAm,
      goals: goals ?? this.goals,
      firstHabit: firstHabit ?? this.firstHabit,
      days: days ?? this.days,
      reminder: reminder ?? this.reminder,
      duration: duration ?? this.duration,
    );
  }
  Map<String, dynamic> toJson() => {
  'currentStep': currentStep,
  'gender': gender,
  'dob': dob?.toIso8601String(),
  'wakeupHour': wakeupHour,
  'wakeupMinute': wakeupMinute,
  'wakeupIsAm': wakeupIsAm,
  'reflectionHour': reflectionHour,
  'reflectionMinute': reflectionMinute,
  'reflectionIsAm': reflectionIsAm,
  'goals': goals,
  'firstHabit': firstHabit,
  'days': days.toList(),
  'reminder': reminder,
  'duration': duration,
};

  @override
  List<Object?> get props => [
    userId,
    currentStep,
    gender,
    dob,
    wakeupHour,
    wakeupMinute,
    wakeupIsAm,
    reflectionHour,
    reflectionMinute,
    reflectionIsAm,
    goals,
    firstHabit,
    days,
    reminder,
    duration,
  ];
}
