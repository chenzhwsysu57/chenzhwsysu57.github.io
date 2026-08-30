---
title: "PatientQA: A Question Answering Benchmark for Patient Diagnosis"
permalink: /blog/patientqa/
author_profile: false
---

<nav class="blog-nav" aria-label="Research note sections">
<a href="#introduction">Introduction</a><a href="#tasks">Tasks for LLM/MLLM</a><a href="#settings">Settings</a><a href="#results">Results</a><a href="#conclusion">Conclusion</a><a href="#links">Links</a>
</nav>

<p class="blog-kicker">Blog · Dec 2024 · Medical QA evaluation</p>

## <span id="introduction">Introduction</span>

Medical evaluation has largely focused on multiple-choice questions, short answers, and recognition of information in medical images. However, clinical practice also requires generating a detailed diagnosis from a patient’s background and interpreting images in that context. PatientQA is designed as a complementary benchmark for these patient-related question-answering abilities, covering both text-only and multimodal evaluation.

## <span id="tasks">Tasks for LLM/MLLM</span>

PatientQA contains two complementary tasks. The OpenQA subset contains **487** questions in two parts: medical history collection and patient-summary diagnosis. Models produce longer diagnostic responses, which are evaluated with a step-by-step comparison against reference answers. The multimodal MCQ subset contains approximately **665** questions collected from medical examination material; each question requires an LLM or MLLM to use the patient context and, where provided, a medical image to select the correct answer.

The benchmark therefore tests whether LLMs can generate comprehensive patient-related medical text and whether MLLMs can integrate visual information into patient diagnosis.

### How PatientQA differs from earlier datasets

Most earlier medical datasets emphasize short answers, image recognition, or knowledge recall. PatientQA combines long-form patient diagnosis with multimodal questions that require medical-image interpretation in a patient context. The table summarizes this difference against representative medical QA benchmarks.

<div class="blog-table-wrap">
<table class="blog-table">
<thead><tr><th>Dataset</th><th>Year</th><th>Amount</th><th>Source</th><th>SOTA</th><th>Modality</th><th>Response</th></tr></thead>
<tbody>
<tr><td>VQA-RAD</td><td>2018</td><td>3515 QA, 315 images</td><td>MedPix</td><td>81.9 PeFoMed</td><td>VQA</td><td>Short</td></tr>
<tr><td>ImageCLEF-2019</td><td>2019</td><td>12792 QA, 3200 images</td><td>Hospital</td><td>62.4 Hanlin</td><td>VQA</td><td>Short</td></tr>
<tr><td>PubMedQA</td><td>2019</td><td>500 test</td><td>PMC</td><td>82 GPT-4</td><td>Text</td><td>Short</td></tr>
<tr><td>PathVQA</td><td>2020</td><td>6012 QA, 1000 test images</td><td>Textbook</td><td>82.75 LLaVA-Med++</td><td>VQA</td><td>Short</td></tr>
<tr><td>MedQA</td><td>2021</td><td>6112 test</td><td>MLE</td><td>91 Med-Gemini</td><td>Text</td><td>MCQ</td></tr>
<tr><td>SLAKE</td><td>2021</td><td>14028 QA, 642 images</td><td>Mixed</td><td>87.8 LLaVA-Med++</td><td>VQA</td><td>Short</td></tr>
<tr><td>MMLU (Med)</td><td>2021</td><td>499 QA</td><td>Textbook</td><td>88.7 Claude 3.5</td><td>Text</td><td>MCQ</td></tr>
<tr><td>MedMCQA</td><td>2022</td><td>6150 test</td><td>MLE</td><td>72.3 Med-PaLM 2</td><td>Text</td><td>MCQ</td></tr>
<tr><td>PMC-VQA</td><td>2023</td><td>227k QA, 149k images</td><td>PMC</td><td>42.3 medVInT</td><td>VQA</td><td>MCQ</td></tr>
<tr><td>CMB</td><td>2023</td><td>11200 test MCQ</td><td>MLE</td><td>74.38</td><td>Text</td><td>MCQ, long</td></tr>
<tr><td>CMExam</td><td>2023</td><td>60000 MCQ</td><td>MLE</td><td>61.7 GPT-4</td><td>Text</td><td>MCQ</td></tr>
<tr><td>MMMU (Med)</td><td>2024</td><td>907 MCQ</td><td>Textbook</td><td>59 Gemini</td><td>VQA</td><td>MCQ</td></tr>
<tr class="ours"><td>PatientQA</td><td>2025</td><td>1151 QA, 815 images</td><td>MLE</td><td>—</td><td>VQA</td><td>MCQ, long</td></tr>
</tbody></table></div>

<p>Across the text-based benchmarks we surveyed, most questions are multiple-choice or short-answer questions. In multimodal benchmarks, questions more often test image recognition, organ identification, or general knowledge than direct diagnosis from patient context.</p>

<div class="blog-figure-grid">
  <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/text-question-types.png' | relative_url }}" alt="Distribution of text-based medical question types"><figcaption>Distribution of question types in representative text-based medical benchmarks.</figcaption></figure>
  <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/multimodal-question-types.png' | relative_url }}" alt="Distribution of multimodal medical question types"><figcaption>Distribution of question types in representative multimodal medical benchmarks.</figcaption></figure>
</div>

<p>The dataset statistics show how the two PatientQA tasks are organized: the MCQ subset is grouped by medical specialty, while the OpenQA subset is grouped by medical system. These distributions reflect the source examination material and the clinical contexts represented in the benchmark.</p>

<div class="blog-figure-grid">
  <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/mcq-distribution.png' | relative_url }}" alt="PatientQA multiple-choice question distribution"><figcaption>Distribution of MCQ questions by medical specialty.</figcaption></figure>
  <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/openqa-distribution.png' | relative_url }}" alt="PatientQA OpenQA question distribution"><figcaption>Distribution of OpenQA questions by medical system.</figcaption></figure>
</div>

## <span id="settings">Settings</span>

PatientQA has two parts: roughly **665** multimodal multiple-choice questions and **487** open-ended questions covering medical history collection and patient-summary diagnosis. For OpenQA, a step-by-step judge compares an answer with a reference before producing a total score. For multimodal MCQ, the evaluation focuses on patient-centered diagnosis rather than generic image recognition.

The experiments compare zero-shot, one-shot, chain-of-thought, and knowledge-augmented settings. For text-only OpenQA, we evaluate Qwen2.5-7B-Instruct, ChatGLM-2-6B, Llama-3.1-8B-Instruct, Vicuna-7B-v1.5, GPT-3.5-Turbo, GPT-4o-mini, and Gemini-1.5-Flash. For multimodal MCQ, we evaluate GPT-4o-mini together with open-source MLLMs including Qwen2-VL, LLaVA-1.5, LLaVA-Med, InstructBLIP, and Llama-3.2-Vision. This mix covers both open-source models at roughly the 7B–11B scale and API-based models.

For MCQ, the evaluation extracts the candidate letter from the model output. For OpenQA, a first judge pass compares the response with the reference step by step, and a second pass extracts the total score. The knowledge-augmented setting supplies the diagnostic cheat sheets included with the dataset.

## <span id="results">Results</span>

The benchmark-level observation is clear: most models perform only marginally above random selection on the multimodal MCQ setting, and even the strongest systems generally remain below the **60%** passing threshold on the patient-summary diagnosis task. On the long-answer task, the proposed semantic score ranked GPT-4o-mini at **52.04/100**, while BLEU/ROUGE could favor repetitive answers such as ChatGLM-2-6B despite its much lower proposed score of **10.11/100**.

One-shot examples usually helped more consistently than long cheat sheets. In contrast, knowledge augmentation could become unstable when the provided reference material exceeded the model’s effective context window. These results suggest that “more medical text” is not automatically better evidence.

<div class="blog-figure-stack">
  <div>
    <h3>Benchmark comparison</h3>
    <p>We measured two capabilities: text-based medical reasoning through long-form OpenQA, and multimodal patient diagnosis through image-based MCQ. PatientQA is more demanding than common benchmarks because it evaluates diagnostic responses and asks MLLMs to combine patient context with medical images. The results show that models remain weak on both tasks: most multimodal models perform only marginally above random selection, while even strong models remain below the 60% examination threshold on patient-summary diagnosis.</p>
  </div>
  <div class="blog-figure-grid">
    <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/text-benchmark.png' | relative_url }}" alt="Text-based medical benchmark comparison"><figcaption>Zero-shot performance on representative text-based medical benchmarks.</figcaption></figure>
    <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/multimodal-benchmark.png' | relative_url }}" alt="Multimodal medical benchmark comparison"><figcaption>Zero-shot performance on representative multimodal medical benchmarks.</figcaption></figure>
  </div>
</div>

<div class="blog-figure-stack blog-figure-stack--full">
  <div>
    <h3>Inspecting visual attention</h3>
    <p>We visualize attention to test whether MLLMs actually focus on medically meaningful content when processing medical images. We find that current models do not attend to medical content as reliably as they attend to natural-image content, revealing a gap in multimodal medical understanding.</p>
  </div>
  <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/attention-map.png' | relative_url }}" alt="Attention visualization for medical and natural images"><figcaption>Attention visualization comparing model focus on medical and natural images.</figcaption></figure>
</div>

<div class="blog-figure-stack">
  <div>
    <h3>Prompting results across the three tasks</h3>
    <p>One-shot examples generally improve medical history collection by helping models follow the reference format. Patient-summary diagnosis remains difficult: even strong models struggle to exceed the 60% examination threshold, and long cheat sheets can exceed the effective context length. For multimodal MCQ, chain-of-thought helps some models, but the gains are inconsistent and model scale alone does not guarantee better medical visual reasoning.</p>
  </div>
  <div class="blog-figure-grid blog-figure-grid--three">
    <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/one-shot-openqa1.png' | relative_url }}" alt="One-shot and KAG medical history results"><figcaption>Medical history collection.</figcaption></figure>
    <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/one-shot-openqa2.png' | relative_url }}" alt="One-shot and KAG diagnosis results"><figcaption>Patient-summary diagnosis.</figcaption></figure>
    <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/one-shot-mcq-full.png' | relative_url }}" alt="Zero-shot one-shot and chain-of-thought MCQ results"><figcaption>Multimodal prompting.</figcaption></figure>
  </div>
</div>

### Metric comparison on OpenQA

<div class="blog-table-wrap">
<table class="blog-table">
<thead><tr><th>Model</th><th>BLEU-1</th><th>BLEU-2</th><th>BLEU-3</th><th>BLEU-4</th><th>ROUGE</th><th>ROUGE-L</th><th>METEOR</th><th>Ours</th></tr></thead>
<tbody>
<tr><td>Pulse-7Bv5</td><td>0.1331</td><td>0.0567</td><td>0.0251</td><td>0.0137</td><td>0.1733</td><td>0.1627</td><td>0.1149</td><td>9.16</td></tr>
<tr><td>HuatuoGPT-7B</td><td>0.1800</td><td>0.0810</td><td>0.0381</td><td>0.0191</td><td>0.1966</td><td>0.1856</td><td>0.1393</td><td>9.30</td></tr>
<tr><td>MMed-Llama-8B</td><td>0.1114</td><td>0.0422</td><td>0.0153</td><td>0.0069</td><td>0.1485</td><td>0.1359</td><td>0.1014</td><td>11.37</td></tr>
<tr><td>Qwen2.5-7B-Instruct</td><td>0.1717</td><td>0.0652</td><td>0.0245</td><td>0.0118</td><td>0.1629</td><td>0.1525</td><td>0.1426</td><td>39.73</td></tr>
<tr><td>ChatGLM-2-6B</td><td>0.1991</td><td>0.0981</td><td>0.0497</td><td>0.0278</td><td>0.2456</td><td>0.2295</td><td>0.1925</td><td>10.11</td></tr>
<tr class="ours"><td>GPT-4o-mini</td><td>0.1818</td><td>0.0669</td><td>0.0240</td><td>0.0111</td><td>0.1659</td><td>0.1551</td><td>0.1471</td><td>52.04</td></tr>
<tr><td>Gemini-1.5-Flash-8B</td><td>0.1720</td><td>0.0677</td><td>0.0239</td><td>0.0108</td><td>0.1655</td><td>0.1575</td><td>0.1655</td><td>32.27</td></tr>
<tr><td>GPT-3.5-Turbo</td><td>0.1069</td><td>0.0391</td><td>0.0141</td><td>0.0071</td><td>0.1502</td><td>0.1407</td><td>0.0981</td><td>14.43</td></tr>
<tr><td>Llama-3.1-8B-Instruct</td><td>0.1697</td><td>0.0683</td><td>0.0239</td><td>0.0118</td><td>0.1629</td><td>0.1525</td><td>0.1426</td><td>16.47</td></tr>
</tbody></table></div>

<div class="blog-figure-stack blog-figure-stack--full">
  <div>
    <h3>Data collection</h3>
    <p>The dataset is built from printed medical exercises containing Medical License Examination (MLE) and OpenQA questions supplied by clinical doctors. Starting from more than 10,000 MCQs, questions are separated according to whether they mention an image. Image-dependent questions are then manually verified when they share images or require context from previous questions, yielding approximately 665 multimodal questions. The OpenQA subset contains 487 questions for medical history collection and patient-summary diagnosis, with reference answers and diagnostic cheat sheets for evaluation.</p>
  </div>
  <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/data-build-process.png' | relative_url }}" alt="PatientQA data collection process"><figcaption>PatientQA data collection process.</figcaption></figure>
  <figure class="blog-figure"><img src="{{ '/images/blog/patientqa/dataset-example-thumbnail.png' | relative_url }}" alt="Dataset example"><figcaption>Dataset example</figcaption></figure>
</div>

## <span id="conclusion">Conclusion</span>

PatientQA complements existing medical benchmarks with two patient-centered evaluation settings. Its OpenQA subset uses step-by-step reasoning to evaluate long-generated diagnostic texts, while its multimodal MCQ subset tests whether MLLMs can use medical images for patient diagnosis. The experiments show that current models still struggle to reach expert-level performance, and that long knowledge-augmentation material can disorient models rather than reliably improve diagnosis. These findings highlight the complexity of medical evaluation and the need for stronger methods for handling patient context and multimodal information.

## <span id="links">Links</span>

- [Technical report (PDF)]({{ '/files/example_paper_latex_2025_medicalVQA.pdf' | relative_url }})
- Code / dataset: not publicly released
