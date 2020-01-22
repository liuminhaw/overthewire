# OverTheWire - Bandit
Level information and notes

## Script usage
`bandit-ssh.sh` script makes it easier to ssh into each level

```bash
./bandit-ssh.sh LEVEL
```
- requirements: `sshpass` command installed

### Text files
Stores password and passing notes for each level
```
levelXX.txt
```

### Pem files
Stores secret key to login via identity file if needed
```
levelXX.pem
```

## Updates

#### 2020-01-22
- Feature to execute command using ssh (level18 need to execute command via ssh)

#### 2020-01-21
- Ability to login with credential (level17 need to use credential to login)