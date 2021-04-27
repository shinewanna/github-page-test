
class Resp {
  dynamic data;
  MsgState message;

  Resp({this.data, this.message = MsgState.loading});
}

enum MsgState {
  loading,
  data,
  error,
}

extension MessageExt on MsgState {
  get isData => this == MsgState.data;
  get isError => this == MsgState.error;
  get isLoading => this == MsgState.loading;
}

