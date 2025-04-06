# Rapid Prototype Stage 1
## Business Requirements
AI "chat" feature that be embedded on any existing website or web application
Host page is able to feed context into the chat seamlessly
Sample page allows users to insert context into the chat through input
## Technical Requirements
Reuseable, modular, and extensible
Rapid deployment is necessary with unspecified degree of reliability, scalability, and maintainability
Application must be secured by modern identity provider
Applications should be simple enough for any web developer to understand
Backend should be simple enough for any Google Cloud developer to understand
Must use industry-standard AI models
Prefer managed services
Minimize cost for low-scale demand
## Design Decisions
Sample page will be a simple HTML + JavaScript application served via Cloud Storage
Chat component will be a simple ES6 JavaScript module that exports a Web Component / custom HTML5 element.
Identity Aware Proxy and Cloud Load Balancing will provide authenticated ingress to the application
API and workflow management application will run on Cloud Run
API will consist of NodeJS backend
API will depend on Vertexai to interface with pre-existing AI models.
Application will be based on a monorepo.
Cloud Domains (optional) for custom DNS.
Terraform IAC will deploy to a specified Google Cloud Provider project
Buildpacks will be used to automate deployment of the NodeJS application
GitHub actions will deploy backend and frontend applications
