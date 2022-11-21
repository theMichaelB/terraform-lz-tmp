#!/bin/bash

TemplateID="7be44c8a-adaf-4e2a-84d6-ab2649e08a13"


### Privileged Authentication Administrator 
az rest --method POST --uri 'https://graph.microsoft.com/beta/roleManagement/directory/roleAssignments' \
 --body '{"principalId": "2a4aefd4-fe9b-4b65-b93f-2b78d9c15f49", "roleDefinitionId": "7be44c8a-adaf-4e2a-84d6-ab2649e08a13", "directoryScopeId": "/"}'