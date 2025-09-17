# ENISA NIS2 Compliance Checklist for SaaS Company

This checklist is based on [ENISA – Technical Implementation Guidance on Cybersecurity Risk Management Measures (v1.0, 2025)](https://www.enisa.europa.eu/sites/default/files/2025-06/ENISA_Technical_implementation_guidance_on_cybersecurity_risk_management_measures_version_1.0.pdf)  
Use it as a roadmap to achieve compliance readiness.  

Status legend:  
- [ ] = ToDo,  ➡️ = In progress
- [x] = Completed   

---

## 1. Security Policy for NIS2
- [ ] **Actions** ➡️
  - Draft and approve Information Security Policy (SaaS/cloud focused).
  - Define roles & responsibilities (CISO, DevSecOps, DPO, CloudOps).
  - Annual review (or more often if required by change management).
- [ ] **Evidence** ➡️
  - Security policy document.
  - Org chart with responsibilities.
  - Meeting minutes / signed approval.

---

## 2. Risk Management Policy & Framework
- [ ] **Actions**
  - Define risk assessment methodology (qualittive or quantitavie).
  - Maintain risk register with SaaS-specific risks.
  - Review at least annually (or more often if required by change management).
- [ ] **Evidence**
  - Risk methodology document.
  - Risk register.
  - Review reports.

---

## 3. Incident Handling
- [ ] **Actions**
  - Create Incident Response Plan (IRP).
  - Implement detection & monitoring (XDR, SIEM).
  - Develop incident playbooks (DDoS, ransomware, authentication bypass...).
  - Conduct incident simulations / tabletop exercises.
- [ ] **Evidence**
  - IRP document.
  - SOC/XDR logs.
  - Playbooks.
  - Simulation reports.

---

## 4. Business Continuity & Crisis Management
- [ ] **Actions**
  - Draft Business Continuity Plan (BCP) and Disaster Recovery Plan (DRP).
  - Define RTO/RPO objectives.
  - Implement backups (on-site & off-site).
  - Test recovery scenarios.
- [ ] **Evidence**
  - BCP/DRP documentation.
  - Backup logs.
  - Recovery tests results.

---

## 5. Supply Chain Security
- [ ] **Actions**
  - Build supplier and external services inventory.
  - Perform third-party risk assessments.
  - Include security clauses in contracts (SLA, breach notification).
- [ ] **Evidence**
  - Supplier inventory list.
  - API assesment reports.
  - Supplier contracts with security clauses.

---

## 6. Acquisition, Development & Maintenance
- [ ] **Actions**
  - Enforce DevSecOps in CI/CD (SAST, DAST).
  - Implement when possible IaC.
  - Define patch management SLAs (critical <24h).
  - Apply secure coding standards (OWASP, API Security).
- [ ] **Evidence**
  - CI/CD pipeline configuration.
  - Patch logs.
  - Secure coding training.
  - Vulnerability scan results.

---

## 7. Assessment of Effectiveness
- [ ] **Actions**
  - Schedule internal security reviews.
  - Perform annual penetration test (or more often if required by change management).
  - Define security KPIs (MTTD, MTTR, patching SLA compliance, RTO/RPO).
- [ ] **Evidence**
  - Internal audit reports.
  - Pentest reports.
  - Security metrics dashboard.
  - Recovery test results.

---

## 8. Cyber Hygiene
- [ ] **Actions**
  - Enforce MFA everywhere.
  - Deploy endpoint protection and automate patching, if possible.
  - Run awareness training & phishing simulations.
- [ ] **Evidence**
  - MFA configuration.
  - Dasboard reports.
  - Training attendance logs.

---

## 9. Cryptography
- [ ] **Actions**
  - Enforce TLS 1.3 for all SaaS services.
  - Encrypt data at rest (AES-256).
  - Manage keys in HSM/KMS.
  - Maintain crypto policy.
- [ ] **Evidence**
  - TLS configuration.
  - Encryption policy.
  - Key management configuration.

---

## 10. Human Resources Security
- [ ] **Actions**
  - Perform background checks (where legally possible).
  - Define onboarding & offboarding procedures.
  - Provide security & secure coding training.
- [ ] **Evidence**
  - HR checklists.
  - Access revocation logs.
  - Training records.

---

## 11. Access Control
- [ ] **Actions**
  - Implement Zero Trust principles.
  - Apply RBAC/ABAC for admin accounts.
  - Enforce least privilege with periodic access reviews.
- [ ] **Evidence**
  - IAM configuration.
  - Role definitions.
  - Access review reports.

---

## 12. Asset Management
- [ ] **Actions**
  - Maintain an asset inventory (VMs, containers, APIs...).
  - Classify assets by criticality and sensitivity.
  - Keep configuration updated.
  - Use an enterprise vault for secrets management.
- [ ] **Evidence**
  - Asset inventory (CMDB).
  - Classification policy.
  - Document configuration review and changing.
  - Vault use policy.

---

## 13. Physical & Environmental Security
- [ ] **Actions**
  - Secure local premises (badges, CCTV, fire protection).
  - Log physical access to DC.
  - Create physical access policy.
- [ ] **Evidence**
  - Office security policy.
  - Visitor logs.

---

# Roadmap Phases for SME

- **Phase 1 (0–3 months):** Governance setup (policies, risk, IRP, BCP/DRP).  
- **Phase 2 (3–6 months):** Technical security (MFA, DevSecOps, monitoring, backups).  
- **Phase 3 (6–12 months):** Maturity (pentests, supply chain, KPI tracking).  
- **Ongoing:** Continuous training, risk reviews, incident simulations, audits.

---
