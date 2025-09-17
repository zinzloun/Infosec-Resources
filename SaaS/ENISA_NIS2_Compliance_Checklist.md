# ENISA NIS2 Compliance Checklist for SaaS Company

This checklist is based on **ENISA – Technical Implementation Guidance on Cybersecurity Risk Management Measures (v1.0, 2025)**.  
Use it as a roadmap to achieve compliance readiness.  

Status legend:  
- [ ] = Not started  
- [~] = In progress  
- [x] = Completed  

---

## 1. Security Policy for NIS
- [ ] **Actions**
  - Draft and approve Information Security Policy (SaaS/cloud focused).
  - Define roles & responsibilities (CISO, DevSecOps, DPO, CloudOps).
  - Annual review and board approval.
- [ ] **Evidence**
  - Security policy document.
  - Org chart with responsibilities.
  - Meeting minutes / signed approval.

---

## 2. Risk Management Policy & Framework
- [ ] **Actions**
  - Define risk assessment methodology (likelihood × impact).
  - Maintain risk register with SaaS-specific risks.
  - Define and approve risk appetite.
  - Review at least annually.
- [ ] **Evidence**
  - Risk methodology document.
  - Risk register.
  - Review reports.

---

## 3. Incident Handling
- [ ] **Actions**
  - Create Incident Response Plan (IRP).
  - Implement detection & monitoring (XDR, SIEM).
  - Develop incident playbooks (DDoS, ransomware, credential abuse).
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
  - Implement backups & geo-redundancy.
  - Test recovery scenarios.
- [ ] **Evidence**
  - BCP/DRP documentation.
  - Backup logs.
  - Recovery test results.

---

## 5. Supply Chain Security
- [ ] **Actions**
  - Build supplier inventory (CSPs, APIs, external services).
  - Perform third-party risk assessments.
  - Include security clauses in contracts (SLA, breach notification).
- [ ] **Evidence**
  - Supplier inventory list.
  - Risk assessment reports.
  - Supplier contracts with security clauses.

---

## 6. Acquisition, Development & Maintenance
- [ ] **Actions**
  - Enforce DevSecOps in CI/CD (SAST, DAST, IaC scanning).
  - Define patch management SLAs (critical <24h).
  - Apply secure coding standards (OWASP ASVS, API Security Top 10).
- [ ] **Evidence**
  - CI/CD pipeline configuration.
  - Patch logs.
  - Secure coding guidelines.
  - Vulnerability scan results.

---

## 7. Assessment of Effectiveness
- [ ] **Actions**
  - Schedule internal security reviews.
  - Perform annual penetration tests.
  - Define security KPIs (MTTD, MTTR, patching SLA compliance).
- [ ] **Evidence**
  - Internal audit reports.
  - Pentest reports.
  - Security metrics dashboard.

---

## 8. Cyber Hygiene
- [ ] **Actions**
  - Enforce MFA everywhere.
  - Deploy endpoint protection & patching.
  - Run awareness training & phishing simulations.
- [ ] **Evidence**
  - MFA enforcement reports.
  - Endpoint agent dashboards.
  - Training attendance logs.

---

## 9. Cryptography
- [ ] **Actions**
  - Enforce TLS 1.3 for all SaaS services.
  - Encrypt data at rest (AES-256).
  - Manage keys in HSM/KMS.
  - Maintain crypto policy.
- [ ] **Evidence**
  - TLS configuration tests.
  - Encryption policy.
  - Key management logs.

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
  - Maintain an asset inventory (VMs, containers, APIs, secrets).
  - Classify assets by criticality and sensitivity.
  - Keep configuration & ownership updated.
- [ ] **Evidence**
  - Asset inventory (CMDB).
  - Classification policy.
  - Ownership records.

---

## 13. Physical & Environmental Security
- [ ] **Actions**
  - Leverage CSP certifications (ISO 27001, SOC 2, CSA STAR).
  - Secure office premises (badges, CCTV, fire protection).
  - Document physical access policy.
- [ ] **Evidence**
  - CSP audit reports.
  - Office security policy.
  - Visitor logs.

---

# Roadmap Phases

- **Phase 1 (0–3 months):** Governance setup (policies, risk, IRP, BCP/DRP).  
- **Phase 2 (3–6 months):** Technical security (MFA, DevSecOps, monitoring, backups).  
- **Phase 3 (6–12 months):** Maturity (pentests, supply chain, KPI tracking).  
- **Ongoing:** Continuous training, risk reviews, incident simulations, audits.

---
