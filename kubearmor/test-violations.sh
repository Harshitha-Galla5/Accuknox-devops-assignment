#!/bin/bash

echo "========================================="
echo " KubeArmor Policy Violation Tests"
echo "========================================="

echo ""
echo "[1] Testing shell execution restriction..."
kubectl exec -it deployment/wisecow-deployment -- /bin/sh

echo ""
echo "[2] Testing package manager restriction..."
kubectl exec -it deployment/wisecow-deployment -- apt update

echo ""
echo "[3] Testing sensitive file access restriction..."
kubectl exec -it deployment/wisecow-deployment -- cat /etc/passwd

echo ""
echo "Violation tests completed."
echo ""
echo "If KubeArmor enforcement is active,"
echo "the above operations should be blocked."
