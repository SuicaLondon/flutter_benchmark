double fibonacci(double n) {
  if (n == 0 || n == 1) {
    return n;
  }
  return fibonacci(n - 1) + fibonacci(n - 2);
}

class TreeNode {
  int treeValue;
  TreeNode? leftChildNode;
  TreeNode? rightChildNode;

  TreeNode(this.treeValue);
}

class BinaryTree {
  TreeNode? root;

  void insertValue(int value) {
    TreeNode newTreeNode = TreeNode(value);

    if (root == null) {
      root = newTreeNode;
    } else {
      TreeNode currentValue = root!;
      while (true) {
        if (value < currentValue.treeValue) {
          if (currentValue.leftChildNode == null) {
            currentValue.leftChildNode = newTreeNode;
            break;
          }
          currentValue = currentValue.leftChildNode!;
        } else {
          if (currentValue.rightChildNode == null) {
            currentValue.rightChildNode = newTreeNode;
            break;
          }
          currentValue = currentValue.rightChildNode!;
        }
      }
    }
  }

  bool containsValue(int value) {
    TreeNode? currentNode = root;
    while (currentNode != null) {
      if (value == currentNode.treeValue) {
        return true;
      } else if (value < currentNode.treeValue) {
        currentNode = currentNode.leftChildNode;
      } else {
        currentNode = currentNode.rightChildNode;
      }
    }
    return false;
  }
}
