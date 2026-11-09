# Kabrail Chamoun - IT Support Portfolio

Hands-on projects that show the skills of a first-line and second-line IT support technician: user accounts and policies, a ticketing help desk with SLAs, and PowerShell diagnostics.

I am looking for a help desk or IT support position. Each project has its own README with the details, screenshots and what I learned.

## Kurzprofil (Deutsch)

Ich bin Informatiker (B.Sc.) und suche eine Stelle im IT-Support bzw. Service Desk. Hier zeige ich drei praktische Projekte, die typische Aufgaben im Support abdecken:

1. **Active-Directory-Testumgebung:** Benutzer, Gruppenrichtlinien (Kennwortrichtlinie, Kontosperrung, Laufwerkszuordnung), Dateifreigaben, FSRM-Kontingente und DHCP
2. **Service Desk in Jira Service Management:** Anfragetypen, Prioritäten P1 bis P4, SLAs, 20 Übungstickets und fünf Wissensdatenbank-Artikel
3. **PowerShell-Werkzeugkasten:** Systeminformationen, Festplattenplatz, Netzwerkprüfung sowie DNS-Cache leeren und IP erneuern (beides mit Rückfrage)

Die Projekte sind auf Englisch dokumentiert. Standort: Göppingen, Baden-Württemberg. Sprachen: Deutsch (C1) und Englisch (C1).

## About me

I am a computer science graduate (B.Sc.) moving into IT support and help desk work. I bring hands-on experience from software projects, technical documentation and debugging, and I built these three projects to practise support skills: Active Directory, ticketing with SLAs, and PowerShell diagnostics.

- **Location:** Göppingen, Baden-Württemberg, Germany (willing to relocate within Germany)
- **Languages:** German (C1), English (C1)
- **Education:** Bachelor of Science in Computer Science (Informatik), Hochschule für Technik Stuttgart (2019 to 2023)
- **Experience:** self-employed software development (since 2024), trainee Java developer, internship in IT warehouse management
- **Find me:** [GitHub](https://github.com/kabraill) | [LinkedIn](https://www.linkedin.com/in/kabrail-chamoun-5b4b30245)

## Projects

### [Project 1: Active Directory home lab](project-1-ad-lab/README.md)

A small Windows domain in virtual machines: Active Directory, Group Policy (password policy, account lockout, drive mapping, wallpaper, Control Panel restriction), file sharing, FSRM quotas and file screening, and DHCP.

- **Skills:** Active Directory, Group Policy, file shares and permissions, FSRM, DHCP, DNS basics, troubleshooting with `ipconfig`, `ping` and `gpupdate`
- **Status:** documented, with screenshots for the policies and file services. I am rebuilding the lab to add the missing screenshots (AD setup, DHCP, DNS). The DNS section is marked "to be completed".

### [Project 2: IT help desk in Jira Service Management](project-2-helpdesk/README.md)

A help desk for a fictional company with request types, P1 to P4 priorities, SLAs, 20 imported practice tickets, a resolution-note template and five knowledge base articles.

- **Skills:** Jira Service Management, SLAs, ticket prioritisation, CSV import and troubleshooting, writing resolution notes and knowledge base articles
- **Status:** set up, with 12 of the 20 tickets resolved. The 8 tickets based on my AD lab stay open until the lab is rebuilt.

### [Project 3: PowerShell help desk toolkit](project-3-powershell-toolkit/README.md)

A menu-driven PowerShell script for quick diagnostics: system info, disk space with a low-space warning, a step-by-step network check, flush DNS and renew IP (both ask for confirmation), and a saved text report.

- **Skills:** PowerShell scripting, network troubleshooting, safe scripting (read-only by default, confirmation before changes), clear commenting
- **Status:** finished.

## How the projects connect

- The tickets in Project 2 are based on faults from the lab in Project 1 (locked account, missing Z: drive, blocked file type, full quota, 169.254 address, domain join error).
- The network check in Project 3 tests the same things I troubleshoot in those tickets: IP address, gateway, internet access and DNS.

## Notes

- All names, companies and tickets are fictional. No real passwords or personal data are included.
- Everything runs in virtual machines or on free plans, with no changes to production systems.
