final String tableReward = 'reward';

class RewardFields {
  static final List<String> values = [id, name_r, coeff];
  static final String id = '_id';
  static final String name_r = 'name_r';
  static final String coeff = 'coeff';
}

class Reward {
  final int? id;
  final String name_r;
  final int? coeff;

  const Reward({
    this.id,
    required this.name_r,
    this.coeff,
  });

  Reward copy({
    int? id,
    String? name_r,
    int? coeff,
  }) =>
      Reward(
        name_r: name_r ?? this.name_r,
        coeff: coeff ?? this.coeff,
      );
  static Reward fromJson(Map<String, Object?> json) => Reward(
      id: json[RewardFields.id] as int?,
      name_r: json[RewardFields.name_r] as String,
      coeff: json[RewardFields.coeff] as int?);
  Map<String, Object?> toJson() => {
        RewardFields.id: id,
        RewardFields.name_r: name_r,
        RewardFields.coeff: coeff
      };
}
