import '../../../../../models/entities/branches/branches_model.dart';

enum BranchesResponseStatus{loading,success,error}
abstract class BranchesStates{}

class BranchesInitState extends BranchesStates{}

class GetBranchesStates extends BranchesStates{
  final String?message;
  final List<BranchesModel>?branchesModels;
  final BranchesResponseStatus?branchesResponseStatus;

  GetBranchesStates({this.message,this.branchesResponseStatus,this.branchesModels});

}