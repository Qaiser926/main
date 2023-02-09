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
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "f26cba646d784bf6840578687384b4f5",
                    "region": "eu-central-1"
                },
                "pinpointTargeting": {
                    "region": "eu-central-1"
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
                            "PoolId": "eu-central-1:a513a9f6-1f50-405d-be0b-5be8c61bdbb2",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_FM6VpWdUi",
                        "AppClientId": "3e7q8hrs8ocls3h2a6t0gtpkt7",
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
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "f26cba646d784bf6840578687384b4f5",
                        "Region": "eu-central-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "eu-central-1"
                    }
                }
            }
        }
    }
}''';