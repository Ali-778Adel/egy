abstract class BranchesEvents{}

class GetBranchesEvent extends BranchesEvents{
  final String?cityId;
  final String?stateId;

  GetBranchesEvent({this.cityId,this.stateId});
}
