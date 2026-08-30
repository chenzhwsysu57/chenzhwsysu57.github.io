---
permalink: /
title: ""
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

Short Bio
=========


Welcome to my homepage! I am currently a research assistant in the [AI Thrust](https://www.hkust-gz.edu.cn/academics/hubs-and-thrust-areas/information-hub/artificial-intelligence/) of the [Information Hub](https://www.hkust-gz.edu.cn/academics/hubs-and-thrust-areas/information-hub/) at [The Hong Kong University of Science and Technology (Guangzhou)](https://www.hkust-gz.edu.cn/), supervised by [Prof. Tianxiang Zhao](https://tianxiangzhao.github.io/). Previously, I worked as a research assistant at [CAIR-HKISI](https://www.cair-cas.org.hk/), supervised by [Prof. Mingyang Zhao](https://zikai1.github.io/). During my spare time, I helped build a code dataset for [MNBVC](https://huggingface.co/datasets/liwu/MNBVC) and helped build the financial RAG system for [Likelihood Lab](http://www.maxlikelihood.cn/).

My current research focuses on the **efficiency, effectiveness, and reliability of AI**, including scenarios involving **agent and multi-agent systems**. Previously, I have worked on benchmarking MLLM performance, fine-tuning domain-specific visual question answering models, and training domain models for image captioning.

<nav class="section-nav" aria-label="On this page">
<a href="#news">News</a><a href="#publications">Publications</a><a href="#projects">Projects</a><a href="#services">Services</a>
</nav>


News
====

<div class="news-scroll" aria-label="News">

<ul>
<li><strong>07/2026</strong> 🎉 Zhongtao Rao's work accepted to <strong>SIGIR 2026</strong>. Congratulations!</li>
<li><strong>04/2026</strong> Joined <strong>HKUST(GZ)</strong>, supervised by <strong>Tianxiang Zhao</strong>.</li>
<li><strong>11/2024</strong> Graduated from <strong>NUS</strong> with a Master's degree in Artificial Intelligence Systems.</li>
<li><strong>08/2024</strong> Contributed Bitbucket dataset to <a href="https://huggingface.co/datasets/liwu/MNBVC">MNBVC</a> through <a href="https://github.com/chenzhwsysu57/bitbucket_crawl_mnbvc">bitbucket_crawl_mnbvc</a>.</li>
<li><strong>02/2024</strong> Joined <a href="https://www.cair-cas.org.hk/">CAIR</a> as intern under the supervision of <strong>Mingyang Zhao</strong>. </li>
<li><strong>08/2023</strong> Joined <a href="http://www.maxlikelihood.cn/">Likelihood Lab</a> under the supervision of <strong>Mingwen Liu</strong>, working on RAG data construction, routing, and retrieval.</li>
<li><strong>06/2022</strong> Graduated from <strong>Sun Yat-sen University (SYSU)</strong>, supervised by <a href="https://ise.sysu.edu.cn/teacher/LiXiying">Xiying Li</a>.</li>
</ul>

</div>
<p class="news-scroll-hint" aria-hidden="true">↕ Scroll for more</p>


Publications
===========

<div class="academic-list">
{% assign publications = site.publications | sort: "date" | reverse %}
{% for publication in publications %}
<article class="academic-card publication-card">
  <div class="academic-card__image">
    <img src="{{ publication.image | default: '/images/500x300.png' | relative_url }}" alt="{{ publication.title }} preview">
  </div>
  <div class="academic-card__body">
    <h2>{{ publication.title }}</h2>
    <p class="academic-card__authors">{% for author in publication.authors %}{% assign author_url = site.author_links[author] %}{% if author == "Zhiwei Chen" %}<strong>{{ author }}</strong>{% elsif author_url %}<a href="{{ author_url }}">{{ author }}</a>{% else %}{{ author }}{% endif %}{% unless forloop.last %}, {% endunless %}{% endfor %}</p>
    <p class="academic-card__venue">{{ publication.venue | default: "Preprint" }} · {{ publication.date | date: "%Y" }}</p>
    {% if publication.excerpt %}<p>{{ publication.excerpt }}</p>{% endif %}
    <p class="academic-card__links">
      {% if publication.paperurl %}<a href="{{ publication.paperurl }}">Paper</a>{% endif %}
      {% if publication.slidesurl %}<a href="{{ publication.slidesurl }}">Slides</a>{% endif %}
      {% if publication.bibtexurl %}<a href="{{ publication.bibtexurl }}">BibTeX</a>{% endif %}
      {% if publication.codeurl %}<a href="{{ publication.codeurl }}">Code</a>{% endif %}
    </p>
  </div>
</article>
{% endfor %}
</div>


Projects
========

<div class="academic-list">
<article class="academic-card project-card">
  <div class="academic-card__image"><img src="{{ '/images/sage.png' | relative_url }}" alt="SAGE project preview"></div>
  <div class="academic-card__body">
    <h2>SAGE: A Self-Evolving Reliable Strategic Reasoning Framework for LLM Game-Playing Agents</h2>
    <p class="academic-card__authors"><strong>Zhiwei Chen</strong>, <a href="https://scholar.google.com/citations?user=8su8b60AAAAJ&hl=en">Tianchun Wang</a>, Tianxiang Zhao</p>
    <p class="academic-card__venue">Aug 2026 · Strategic reasoning and self-evolving agents</p>
    <p class="academic-card__links"><a href="https://chenzhwsysu57.github.io/SAGE/">Homepage</a> <a href="https://github.com/chenzhwsysu57/SAGE">GitHub</a></p>
  </div>
</article>

<article class="academic-card project-card">
  <div class="academic-card__image"><img src="{{ '/images/echocare.png' | relative_url }}" alt="EchoCare preview"></div>
  <div class="academic-card__body">
    <h2>EchoCare: A fully open and generalizable foundation model for ultrasound clinical applications</h2>
    <p class="academic-card__authors">Hongyuan Zhang, Yuheng Wu, Mingyang Zhao, <strong>Zhiwei Chen</strong>, Rebecca Li, Fei Zhu, Haohan Zhao, Xiaohua Yuan, Meng Yang, Chunli Qiu, Xiang Cong, Haiyan Chen, Lina Luan, Randolph H.L. Wong, Huai Liao, Colin A Graham, Shi Chang, Guowei Tao, Dong Yi, Zhen Lei, Nassir Navab, Sebastien Ourselin, Jiebo Luo, Hongbin Liu, Gaofeng Meng</p>
    <p class="academic-card__venue">Sept 2025 · Open-source foundation model for ultrasound clinical applications</p>
    <p class="academic-card__links"><a href="https://echocare.cares-copilot.com/">Homepage</a> <a href="https://github.com/CAIR-HKISI/EchoCare">GitHub</a> <a href="https://huggingface.co/CAIR-HKISI">Hugging Face</a> <a href="http://arxiv.org/abs/2509.11752">arXiv</a></p>
  </div>
</article>

<article class="academic-card project-card">
  <div class="academic-card__image"><img src="{{ '/images/blog/curdnet/architecture.png' | relative_url }}" alt="CURDNet model architecture"></div>
  <div class="academic-card__body">
    <h2>CURDNet: Contrastive Ultrasound Report Generation with Diversity-Aware Learning</h2>
    <p class="academic-card__authors">personal project</p>
    <p class="academic-card__venue">Aug 2025 · Research blog on diverse ultrasound report generation</p>
    <p class="academic-card__links"><a href="{{ '/blog/curdnet/' | relative_url }}">Blog</a> <a href="{{ '/files/anonymous-submission-latex-2026-curdnet.pdf' | relative_url }}">Technical report</a></p>
  </div>
</article>

<article class="academic-card project-card">
  <div class="academic-card__image"><img src="{{ '/images/blog/patientqa/dataset-example-thumbnail.png' | relative_url }}" alt="PatientQA dataset example"></div>
  <div class="academic-card__body">
    <h2>PatientQA: A Question Answering Benchmark for Patient Diagnosis</h2>
    <p class="academic-card__authors">personal project</p>
    <p class="academic-card__venue">Dec 2024 · Research blog on patient-centered medical QA evaluation</p>
    <p class="academic-card__links"><a href="{{ '/blog/patientqa/' | relative_url }}">Blog</a> <a href="{{ '/files/example_paper_latex_2025_medicalVQA.pdf' | relative_url }}">Technical report</a></p>
  </div>
</article>
</div>


Services
========

- Reviewer, **AAAI**
- Reviewer, **CIKM**
