// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: (fields[0] as num).toInt(),
      title: fields[1] as String,
      price: (fields[2] as num).toDouble(),
      category: fields[3] as Categories,
      stock: (fields[4] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.stock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final typeId = 1;

  @override
  Categories read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Categories.beauty;
      case 1:
        return Categories.fragrances;
      default:
        return Categories.beauty;
    }
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    switch (obj) {
      case Categories.beauty:
        writer.writeByte(0);
      case Categories.fragrances:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubscriptionTypeAdapter extends TypeAdapter<SubscriptionType> {
  @override
  final typeId = 2;

  @override
  SubscriptionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubscriptionType.free;
      case 1:
        return SubscriptionType.premium;
      case 2:
        return SubscriptionType.enterprise;
      default:
        return SubscriptionType.free;
    }
  }

  @override
  void write(BinaryWriter writer, SubscriptionType obj) {
    switch (obj) {
      case SubscriptionType.free:
        writer.writeByte(0);
      case SubscriptionType.premium:
        writer.writeByte(1);
      case SubscriptionType.enterprise:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenderAdapter extends TypeAdapter<Gender> {
  @override
  final typeId = 3;

  @override
  Gender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  @override
  void write(BinaryWriter writer, Gender obj) {
    switch (obj) {
      case Gender.male:
        writer.writeByte(0);
      case Gender.female:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserProfileModelAdapter extends TypeAdapter<UserProfileModel> {
  @override
  final typeId = 4;

  @override
  UserProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileModel(
      userId: fields[0] as String,
      userEmail: fields[1] as String,
      createdAt: fields[2] as DateTime,
      subscriptionType: fields[3] as SubscriptionType,
      profileCompleted: fields[8] as bool,
      weight: (fields[4] as num?)?.toDouble(),
      height: (fields[5] as num?)?.toDouble(),
      age: (fields[6] as num?)?.toInt(),
      gender: fields[7] as Gender?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userEmail)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.subscriptionType)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.age)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.profileCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MuscleGroupAdapter extends TypeAdapter<MuscleGroup> {
  @override
  final typeId = 5;

  @override
  MuscleGroup read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MuscleGroup.chest;
      case 1:
        return MuscleGroup.shoulders;
      case 2:
        return MuscleGroup.triceps;
      case 3:
        return MuscleGroup.back;
      case 4:
        return MuscleGroup.biceps;
      case 5:
        return MuscleGroup.quads;
      case 6:
        return MuscleGroup.hamstrings;
      case 7:
        return MuscleGroup.glutes;
      case 8:
        return MuscleGroup.calves;
      case 9:
        return MuscleGroup.abs;
      case 10:
        return MuscleGroup.cardio;
      case 11:
        return MuscleGroup.none;
      case 12:
        return MuscleGroup.core;
      case 13:
        return MuscleGroup.lats;
      default:
        return MuscleGroup.chest;
    }
  }

  @override
  void write(BinaryWriter writer, MuscleGroup obj) {
    switch (obj) {
      case MuscleGroup.chest:
        writer.writeByte(0);
      case MuscleGroup.shoulders:
        writer.writeByte(1);
      case MuscleGroup.triceps:
        writer.writeByte(2);
      case MuscleGroup.back:
        writer.writeByte(3);
      case MuscleGroup.biceps:
        writer.writeByte(4);
      case MuscleGroup.quads:
        writer.writeByte(5);
      case MuscleGroup.hamstrings:
        writer.writeByte(6);
      case MuscleGroup.glutes:
        writer.writeByte(7);
      case MuscleGroup.calves:
        writer.writeByte(8);
      case MuscleGroup.abs:
        writer.writeByte(9);
      case MuscleGroup.cardio:
        writer.writeByte(10);
      case MuscleGroup.none:
        writer.writeByte(11);
      case MuscleGroup.core:
        writer.writeByte(12);
      case MuscleGroup.lats:
        writer.writeByte(13);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MuscleGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EquipmentAdapter extends TypeAdapter<Equipment> {
  @override
  final typeId = 6;

  @override
  Equipment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Equipment(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Equipment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MuscleAdapter extends TypeAdapter<Muscle> {
  @override
  final typeId = 7;

  @override
  Muscle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Muscle(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      muscleGroup: fields[3] as MuscleGroup,
    );
  }

  @override
  void write(BinaryWriter writer, Muscle obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.muscleGroup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MuscleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final typeId = 8;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      muscleCategory: fields[3] as MuscleCategory,
      primaryMuscle: fields[4] as Muscle,
      secondaryMusclesIds: (fields[5] as List).cast<String>(),
      equipment: fields[6] as Equipment,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.muscleCategory)
      ..writeByte(4)
      ..write(obj.primaryMuscle)
      ..writeByte(5)
      ..write(obj.secondaryMusclesIds)
      ..writeByte(6)
      ..write(obj.equipment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MuscleCategoryAdapter extends TypeAdapter<MuscleCategory> {
  @override
  final typeId = 9;

  @override
  MuscleCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MuscleCategory.push;
      case 1:
        return MuscleCategory.pull;
      case 2:
        return MuscleCategory.legs;
      case 3:
        return MuscleCategory.core;
      case 4:
        return MuscleCategory.cardio;
      default:
        return MuscleCategory.push;
    }
  }

  @override
  void write(BinaryWriter writer, MuscleCategory obj) {
    switch (obj) {
      case MuscleCategory.push:
        writer.writeByte(0);
      case MuscleCategory.pull:
        writer.writeByte(1);
      case MuscleCategory.legs:
        writer.writeByte(2);
      case MuscleCategory.core:
        writer.writeByte(3);
      case MuscleCategory.cardio:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MuscleCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final typeId = 10;

  @override
  Workout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workout(
      id: fields[0] as String,
      name: fields[1] as String,
      workoutExercises: (fields[2] as List).cast<WorkoutExercise>(),
      duration: (fields[3] as num).toInt(),
      difficulty: fields[4] as WorkoutDifficulty,
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.workoutExercises)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.difficulty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutExerciseAdapter extends TypeAdapter<WorkoutExercise> {
  @override
  final typeId = 11;

  @override
  WorkoutExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutExercise(
      exercise: fields[0] as Exercise,
      sets: (fields[1] as num).toInt(),
      reps: (fields[2] as num).toInt(),
      restTimeInSeconds: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutExercise obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exercise)
      ..writeByte(1)
      ..write(obj.sets)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.restTimeInSeconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutDifficultyAdapter extends TypeAdapter<WorkoutDifficulty> {
  @override
  final typeId = 12;

  @override
  WorkoutDifficulty read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkoutDifficulty.easy;
      case 1:
        return WorkoutDifficulty.medium;
      case 2:
        return WorkoutDifficulty.hard;
      default:
        return WorkoutDifficulty.easy;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutDifficulty obj) {
    switch (obj) {
      case WorkoutDifficulty.easy:
        writer.writeByte(0);
      case WorkoutDifficulty.medium:
        writer.writeByte(1);
      case WorkoutDifficulty.hard:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutDifficultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutPlanAdapter extends TypeAdapter<WorkoutPlan> {
  @override
  final typeId = 13;

  @override
  WorkoutPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutPlan(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      workouts: (fields[3] as List).cast<Workout>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutPlan obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.workouts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
