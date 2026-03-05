---
layout: archive
title: "CV"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
---

{% include base_path %}

Education
======
* M.Tech. in Singapore, National University of Singapore, 2024
* B.Eng. in Guangzhou, Sun Yat-sen University, 2022

Work experience
======
* Spring 2024: Research Assistant
  * Ceter for Artificial Intelligence and Robotics, Hong Kong
  * Duties includes: data scraping and cleaning; PDF parsing; LLM/VLM deployment and testing; benchmarking medical QA/VQA under one shot, zero shot and chain of thought; benchmarking report generation; CLIP domain pretraining
  * Supervisor: [Mingyang Zhao](https://zikai1.github.io/)

* Fall 2023: Intern
  * Likelihood Lab, Guangzhou, China
  * Duties included: multiple finance news scraping, RAG data storing and QA routing; FinRobot multiple function implementation
  * Supervisor: [Mingwen Liu](http://www.maxlikelihood.cn)

Skills
======
* RAG system building
  * chroma data storing
  * query filter support
  * knowledge regular update and deduplicate
* Agent system building
  * LLM decision making
  * automation tool
  * FSM modeling
* Contrastive learning
  * data scraping
  * noisy weak supervision
* Multimodal learning
  * image caption



Publications
======
  <ul>{% for post in site.publications reversed %}
    {% include archive-single-cv.html %}
  {% endfor %}</ul>
  

