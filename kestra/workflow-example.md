```yaml
id: ansible
namespace: dev

labels:
  env: dev
  projects: homelab

inputs:
  - id: host
    type: STRING
    required: true
    description: "hostname-input"
    defaults:
      - "pve-containers"

  - id: playbooks
    type: STRING
    required: true
    description: "playbook-input"
    defaults:
      - "playbooks/maintainance/clear_cache.yaml"

tasks:
  - id: maintainance
    type: io.kestra.core.tasks.flows.WorkingDirectory
    tasks:
      - id: git_clone
        type: io.kestra.plugin.git.Clone
        url: git@github.com:avalon649/ansible-semaphore.git
        branch: master
        privateKey: "{{ secret('GITHUB_SSH') }}"

      - id: load_ssh_key
        type: io.kestra.core.tasks.storages.LocalFiles   
        inputs:
          id_rsa: "{{ secret('SSH_KEY') }}"
          
      - id: ansible
        type: io.kestra.plugin.ansible.cli.AnsibleCLI
        commands:
          - ansible-playbook -i inventory/homelab --key-file id_rsa --extra-vars "hosts={{ inputs.host }}" "{{ inputs.playbooks }}"
          #playbooks/maintainance/check-disk-space.yaml
        docker:
          image: cytopia/ansible:latest-tools
          pullPolicy: IF_NOT_PRESENT
          user: "1000"

        env:
          ANSIBLE_HOST_KEY_CHECKING: "False"  
          ANSIBLE_REMOTE_USER: "serveradmin"

# triggers:
#   - id: daily
#     type: io.kestra.core.models.triggers.types.Schedule
#     cron: "0 9 * * *"
```