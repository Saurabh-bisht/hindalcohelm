#!/bin/bash

echo "Starting Helm packaging and dependency update process..."
echo "===================================================="

# Package hindalco-common
echo "📦 Packaging hindalco-common..."
cd hindalco-common
helm package .
echo "✅ hindalco-common packaged"
echo "------------------------"

# Array of microservices
SERVICES=(
    "apigateway"
    "discovery"
    "helperservice"
    "iotservice"
    "plantmicroservice"
    "readerservice"
    "userservice"
    "broker"
)

# Go to microservices directory
cd ../hindalco-ms

# Update dependencies and package each service
for service in "${SERVICES[@]}"; do
    echo "🔄 Processing $service..."
    cd $service
    
    echo "Updating dependencies for $service..."
    helm dependency update
    
    echo "Packaging $service..."
    helm package .
    
    cd ..
    echo "✅ $service completed"
    echo "------------------------"
done

# Update dev-env dependencies
echo "🔄 Updating dev-env dependencies..."
cd ../environments/dev-env
helm dependency update
echo "✅ dev-env dependencies updated"

echo "===================================================="
echo "✨ All packaging and dependency updates completed!"
echo "You can now run: helm template hindalco . or helm upgrade hindalco ."