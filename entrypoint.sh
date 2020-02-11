#!/bin/bash

# Install platform-tools if needed
if ! [ -e /android-sdk/tools/bin/sdkmanager ]; then
	# Unzip android sdk
	unzip -d /android-sdk /android-sdk.zip

	# Accept all licences
	yes | /android-sdk/tools/bin/sdkmanager --licenses
	yes | /android-sdk/tools/bin/sdkmanager "platform-tools"
fi

exec "$@"
