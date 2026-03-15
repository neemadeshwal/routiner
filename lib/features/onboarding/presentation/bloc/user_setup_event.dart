class UserSetupEvent {}


// Navigation 
class UserSetupNextStep extends UserSetupEvent{}

class UserSetupPreviousStep extends UserSetupEvent{}

class UserSetupComplete extends UserSetupEvent{}

class UserSetupGenderSelected extends UserSetupEvent{
  final String gender;
  UserSetupGenderSelected({required this.gender});
}

class UserSetupDobSelected extends UserSetupEvent{
  final DateTime dob;

  UserSetupDobSelected({required this.dob});
}

class UserSetupWakeupSelected extends UserSetupEvent{
  final int hour;
  final int minute;
  final bool isAm;

  UserSetupWakeupSelected({required this.hour,required this.minute,required this.isAm});
}

class UserSetupReflectionSelected extends UserSetupEvent{
  final int hour;
  final int minute;
  final bool isAm;

  UserSetupReflectionSelected({required this.hour,required this.minute,required this.isAm});
}

class UserSetupGoalsSelected extends UserSetupEvent{
  final List<String> goals;

  UserSetupGoalsSelected({required this.goals});
}

class UserSetupFirstHabitSelected extends UserSetupEvent{
  final String habit;
  UserSetupFirstHabitSelected({required this.habit});
}

class UserSetupSetGoalSelected extends UserSetupEvent{
  final Set<String> days;
  final String reminder;
  final String duration;

  UserSetupSetGoalSelected({required this.days,required this.reminder,required this.duration});
}