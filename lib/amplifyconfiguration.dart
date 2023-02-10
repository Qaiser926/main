const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "othiaApi": {
                    "endpointType": "REST",
                    "endpoint": "https://ex9ty47js8.execute-api.eu-central-1.amazonaws.com/dev",
                    "region": "eu-central-1",
                    "authorizationType": "NONE"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-central-1:d5ee9269-e4aa-49fb-ba15-e0f8e674b35c",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_zPbMhNl6a",
                        "AppClientId": "2ql55su85nheo2tdi3tl4avgoq",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OPTIONAL",
                        "mfaTypes": [
                            "SMS",
                            "TOTP"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                }
            }
        }
    }
}''';