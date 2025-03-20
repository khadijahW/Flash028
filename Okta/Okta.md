<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Okta Integration Documentation</title>
</head>
<body>
    <h1>Okta Integration Documentation</h1>
    <p>This document provides a step-by-step guide for integrating Okta into your organization. It covers account creation, SAML 2.0 configuration, policy rules, and attribute mapping.</p>

    <h2>Introduction</h2>
    <p>Okta is a cloud-based identity and access management solution that enables organizations to manage user authentication and authorization. This guide focuses on setting up Okta for seamless integration with your systems.</p>

    <h2>Focus Items</h2>
    <ul>
        <li>Account Creation</li>
        <li>Configuring SAML 2.0 for Okta Org2Org Application</li>
        <li>Setting Up Global Session Policy Rules</li>
        <li>Setting Up Authentication Policy Rules</li>
        <li>Attribute Mapping and Offboarding</li>
    </ul>

    <h2>Account Creation</h2>
    <p>Follow these steps to create an Okta account:</p>
    <ol>
        <li>Visit the <a href="https://www.okta.com/">Okta website</a> and sign up for an account.</li>
        <li>Verify your email address and complete the initial setup wizard.</li>
        <li>Configure your organization's domain and add users.</li>
    </ol>

    <h2>Configuring SAML 2.0 for Okta Org2Org Application</h2>
    <p>To configure SAML 2.0 for the Okta Org2Org application:</p>
    <ol>
        <li>Navigate to the Okta Admin Dashboard.</li>
        <li>Go to <strong>Applications</strong> > <strong>Add Application</strong>.</li>
        <li>Search for "Org2Org" and add it to your organization.</li>
        <li>Configure the SAML settings, including the Assertion Consumer Service (ACS) URL and Audience URI.</li>
        <li>Download the metadata file and upload it to your partner organization's Okta instance.</li>
    </ol>

    <h2>Setting Up Global Session Policy Rules</h2>
    <p>Global session policies control how users interact with Okta across devices and locations. To set up global session policy rules:</p>
    <ol>
        <li>Go to <strong>Security</strong> > <strong>Global Session Policy</strong> in the Okta Admin Dashboard.</li>
        <li>Create a new policy or edit an existing one.</li>
        <li>Define rules based on factors like location, device type, and network zone.</li>
        <li>Save and apply the policy.</li>
    </ol>

    <h2>Setting Up Authentication Policy Rules</h2>
    <p>Authentication policies determine how users authenticate to Okta. To set up authentication policy rules:</p>
    <ol>
        <li>Navigate to <strong>Security</strong> > <strong>Authentication Policies</strong>.</li>
        <li>Create a new policy or edit an existing one.</li>
        <li>Configure rules for factors like password complexity, multi-factor authentication (MFA), and sign-on attempts.</li>
        <li>Save and apply the policy.</li>
    </ol>

    <h2>Attribute Mapping and Offboarding</h2>
    <p>Attribute mapping ensures that user attributes are correctly passed between systems. Offboarding ensures that users are deprovisioned when they leave the organization.</p>
    <ol>
        <li>Go to <strong>Applications</strong> > <strong>Your Org2Org Application</strong> > <strong>Sign-On</strong> tab.</li>
        <li>Configure attribute mappings to match your organization's requirements.</li>
        <li>For offboarding, set up a deprovisioning policy in the <strong>Provisioning</strong> tab to automatically deactivate users when they leave.</li>
    </ol>

    <h2>Account Creation Steps</h2>
    <p>Refer to the <a href="#account-creation">Account Creation</a> section above for detailed steps.</p>

    <h2>Org2Org</h2
