abstract class KeyAction {
  String execute(String currentAmount);
}
class DigitKey extends KeyAction {
  final String digit;

  DigitKey(this.digit);

  @override
  String execute(String currentAmount) =>
      currentAmount == '0.00' ? digit : currentAmount + digit;
}

class DecimalKey extends KeyAction {
  @override
  String execute(String currentAmount) =>
      currentAmount.contains('.') ? currentAmount : currentAmount + '.';
}

class BackspaceKey extends KeyAction {
  @override
  String execute(String currentAmount) {
    final newValue = currentAmount.length > 1
        ? currentAmount.substring(0, currentAmount.length - 1)
        : '0.00';
    return newValue.isEmpty ? '0.00' : newValue;
  }
}
class ClearKey extends KeyAction {
  @override
  String execute(String currentAmount) => '0.00';
  
}
