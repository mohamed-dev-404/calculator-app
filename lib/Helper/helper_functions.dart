String opration(String LHS, String op, String RHS) {
    if (op == '+') {
      return (double.parse(LHS) + double.parse(RHS)).toString();
    } else if (op == '-') {
      return (double.parse(LHS) - double.parse(RHS)).toString();
    } else if (op == '*') {
      return (double.parse(LHS) * double.parse(RHS)).toString();
    } else if (op == '/') {
      return (double.parse(LHS) / double.parse(RHS)).toString();
    } else {
      return '';
    }
  }