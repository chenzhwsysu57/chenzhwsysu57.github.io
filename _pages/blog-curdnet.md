---
title: "CURDNet: Contrastive Ultrasound Report Generation with Diversity-Aware Learning"
permalink: /blog/curdnet/
author_profile: false
---

<nav class="blog-nav" aria-label="Blog sections">
<a href="#question">TLDR</a><a href="#why">Introduction</a><a href="#tried">Method</a><a href="#results">Key results</a><a href="#conclusion">Conclusion</a><a href="#links">Links</a>
</nav>

<p class="blog-kicker">Blog · Aug 2025 · Ultrasound report generation</p>

## <span id="question">TLDR</span>

In this blog we investigate the difference between ultrasound images and x-ray images, and try to train a model for ultrasound report generation.

<div class="blog-text-image">

  <div>
    <h2 id="why">Introduction</h2>

    <p>
      Ultrasound is used across many organs, and the image appearance depends heavily
      on the operator, view, and clinical setting. That makes the data much less uniform
      than many chest X-ray benchmarks. A model that performs well on one organ can
      therefore struggle when the next case looks completely different. As shown in the figure at right hand side, the X-ray image pairs are relatively similar, difference are mainly focused on local; while the ultrasound image pairs are more diverse. So we come up with the idea, instead of modify the transformer model to focus on local difference between different cases, we want the model to identify differences between cases level -- we bring a CLIP task into training a image caption model.
    </p>
  </div>

  <figure class="blog-figure">
    <img
      src="{{ '/images/blog/curdnet/modality-comparison.png' | relative_url }}"
      alt="Comparison of X-ray and ultrasound data diversity"
    >
    <figcaption>
      Ultrasound cases vary more across organs and acquisition settings than the
      standardized views common in chest X-ray data.
    </figcaption>
  </figure>

</div>

## <span id="tried">Method</span>

CURDNet combines three lightweight ideas:

- **EchoDice**. We come up with the idea to use a very simple but effective strategy. Instead of training three distinct models for respective subsets, we use one model to train all samples,  with high within-batch diversity being able to, encourage the model to learn across organs instead of memorizing one visual style.
- **ReportMatcher**. This is the CLIP module adds image-report contrastive learning so matched pairs move closer and mismatched pairs move apart.
- **ReportJudger** uses an LLM-based scorer to check whether retrieved reports are clinically and semantically relevant, in order to tell whether our encoder actually learns the case difference.

The system trains a shared model for mammary, thyroid, and liver ultrasound reports rather than maintaining one model per organ.

<figure class="blog-figure">
<img src="{{ '/images/blog/curdnet/architecture.png' | relative_url }}" alt="CURDNet model architecture">
<figcaption>CURDNet combines diversity-aware sampling, report-image matching, report generation, and an LLM-based relevance judge.</figcaption>
</figure>

## <span id="results">Key results</span>

On the reported benchmark, the full model achieved BLEU-1 scores of **0.763 / 0.733 / 0.879** on mammary, thyroid, and liver subsets, respectively. The corresponding clinical F1 scores were **0.905 / 0.918 / 0.900**. For image-to-text retrieval, the top-1 relevance score improved from **0.27 to 0.71**, while the bottom-1 mismatched score fell from **0.22 to 0.05**.

The gains are not just about longer text: the clinical precision, recall, and F1 results suggest that the generated reports remain better aligned with the relevant findings.

### Main experiment results

<div class="blog-table-wrap">
<table class="blog-table">
<thead><tr><th>Split</th><th>Method</th><th>B-1</th><th>B-2</th><th>B-3</th><th>B-4</th><th>METEOR</th><th>ROUGE-L</th><th>Accuracy</th><th>Precision</th><th>Recall</th><th>F1</th></tr></thead>
<tbody>
<tr><td rowspan="8">Mammary</td><td>CNN-RNN</td><td>0.114</td><td>0.093</td><td>0.078</td><td>0.067</td><td>0.221</td><td>0.185</td><td>0.000</td><td>0.496</td><td>0.498</td><td>0.487</td></tr>
<tr><td>TriNet</td><td>0.693</td><td>0.594</td><td>0.533</td><td>0.478</td><td>0.439</td><td>0.742</td><td>0.351</td><td>0.816</td><td>0.697</td><td>0.727</td></tr>
<tr><td>R2Gen</td><td>0.663</td><td>0.611</td><td>0.572</td><td>0.541</td><td>0.411</td><td>0.685</td><td>0.494</td><td>0.800</td><td>0.761</td><td>0.776</td></tr>
<tr><td>Transformer</td><td>0.699</td><td>0.653</td><td>0.619</td><td>0.590</td><td>0.437</td><td>0.757</td><td>0.461</td><td>0.827</td><td>0.671</td><td>0.702</td></tr>
<tr><td>DeltaNet</td><td>0.716</td><td>0.665</td><td>0.638</td><td>0.608</td><td>0.517</td><td>0.758</td><td>0.573</td><td>0.819</td><td>0.819</td><td>0.818</td></tr>
<tr><td>R2GenRL</td><td>0.672</td><td>0.595</td><td>0.531</td><td>0.479</td><td>0.500</td><td>0.651</td><td>0.424</td><td>0.793</td><td>0.754</td><td>0.771</td></tr>
<tr><td>SGF</td><td>0.761</td><td>0.710</td><td>0.672</td><td>0.640</td><td>0.468</td><td>0.758</td><td>0.586</td><td>0.815</td><td>0.831</td><td>0.822</td></tr>
<tr class="ours"><td>Ours</td><td>0.763</td><td>0.711</td><td>0.670</td><td>0.637</td><td>0.470</td><td>0.755</td><td>0.547</td><td>0.905</td><td>0.906</td><td>0.905</td></tr>
<tr><td rowspan="8">Thyroid</td><td>CNN-RNN</td><td>0.131</td><td>0.105</td><td>0.086</td><td>0.069</td><td>0.069</td><td>0.207</td><td>0.000</td><td>0.448</td><td>0.348</td><td>0.382</td></tr>
<tr><td>TriNet</td><td>0.645</td><td>0.510</td><td>0.421</td><td>0.345</td><td>0.409</td><td>0.678</td><td>0.268</td><td>0.845</td><td>0.769</td><td>0.803</td></tr>
<tr><td>R2Gen</td><td>0.578</td><td>0.532</td><td>0.492</td><td>0.457</td><td>0.369</td><td>0.664</td><td>0.404</td><td>0.810</td><td>0.768</td><td>0.779</td></tr>
<tr><td>Transformer</td><td>0.709</td><td>0.642</td><td>0.585</td><td>0.538</td><td>0.425</td><td>0.701</td><td>0.260</td><td>0.717</td><td>0.732</td><td>0.724</td></tr>
<tr><td>DeltaNet</td><td>0.610</td><td>0.559</td><td>0.515</td><td>0.579</td><td>0.443</td><td>0.685</td><td>0.363</td><td>0.837</td><td>0.784</td><td>0.795</td></tr>
<tr><td>R2GenRL</td><td>0.616</td><td>0.595</td><td>0.464</td><td>0.414</td><td>0.470</td><td>0.599</td><td>0.434</td><td>0.834</td><td>0.819</td><td>0.826</td></tr>
<tr><td>SGF</td><td>0.729</td><td>0.666</td><td>0.613</td><td>0.568</td><td>0.439</td><td>0.723</td><td>0.524</td><td>0.838</td><td>0.850</td><td>0.841</td></tr>
<tr class="ours"><td>Ours</td><td>0.733</td><td>0.670</td><td>0.615</td><td>0.568</td><td>0.440</td><td>0.726</td><td>0.514</td><td>0.912</td><td>0.924</td><td>0.918</td></tr>
<tr><td rowspan="8">Liver</td><td>CNN-RNN</td><td>0.049</td><td>0.026</td><td>0.011</td><td>0.000</td><td>0.119</td><td>0.102</td><td>0.000</td><td>0.181</td><td>0.068</td><td>0.070</td></tr>
<tr><td>TriNet</td><td>0.868</td><td>0.821</td><td>0.785</td><td>0.750</td><td>0.531</td><td>0.861</td><td>0.039</td><td>0.898</td><td>0.809</td><td>0.814</td></tr>
<tr><td>R2Gen</td><td>0.866</td><td>0.842</td><td>0.822</td><td>0.805</td><td>0.537</td><td>0.869</td><td>0.530</td><td>0.875</td><td>0.880</td><td>0.870</td></tr>
<tr><td>Transformer</td><td>0.855</td><td>0.832</td><td>0.815</td><td>0.800</td><td>0.524</td><td>0.873</td><td>0.444</td><td>0.749</td><td>0.785</td><td>0.765</td></tr>
<tr><td>DeltaNet</td><td>0.873</td><td>0.846</td><td>0.825</td><td>0.808</td><td>0.593</td><td>0.862</td><td>0.568</td><td>0.900</td><td>0.878</td><td>0.874</td></tr>
<tr><td>R2GenRL</td><td>0.853</td><td>0.818</td><td>0.791</td><td>0.769</td><td>0.575</td><td>0.842</td><td>0.466</td><td>0.885</td><td>0.875</td><td>0.879</td></tr>
<tr><td>SGF</td><td>0.872</td><td>0.848</td><td>0.828</td><td>0.813</td><td>0.539</td><td>0.875</td><td>0.541</td><td>0.879</td><td>0.894</td><td>0.883</td></tr>
<tr class="ours"><td>Ours</td><td>0.879</td><td>0.851</td><td>0.828</td><td>0.810</td><td>0.544</td><td>0.874</td><td>0.579</td><td>0.901</td><td>0.899</td><td>0.900</td></tr>
</tbody></table></div>

### Ablation results

<div class="blog-table-wrap">
<table class="blog-table">
<thead><tr><th>Split</th><th>Setting</th><th>B-1</th><th>B-4</th><th>METEOR</th><th>ROUGE-L</th></tr></thead>
<tbody>
<tr><td rowspan="5">Mammary</td><td>TF</td><td>0.699</td><td>0.590</td><td>0.437</td><td>0.757</td></tr><tr><td>w/ Matcher</td><td>0.733</td><td>0.598</td><td>0.455</td><td>0.736</td></tr><tr><td>w/ Dice</td><td>0.729</td><td>0.586</td><td>0.446</td><td>0.731</td></tr><tr class="ours"><td>Ours</td><td>0.763</td><td>0.637</td><td>0.470</td><td>0.755</td></tr><tr><td>Ours + cls</td><td>0.757</td><td>0.612</td><td>0.460</td><td>0.755</td></tr>
<tr><td rowspan="5">Thyroid</td><td>TF</td><td>0.709</td><td>0.538</td><td>0.425</td><td>0.701</td></tr><tr><td>w/ Matcher</td><td>0.728</td><td>0.560</td><td>0.435</td><td>0.723</td></tr><tr><td>w/ Dice</td><td>0.690</td><td>0.529</td><td>0.416</td><td>0.715</td></tr><tr class="ours"><td>Ours</td><td>0.733</td><td>0.568</td><td>0.440</td><td>0.726</td></tr><tr><td>Ours + cls</td><td>0.729</td><td>0.562</td><td>0.434</td><td>0.726</td></tr>
<tr><td rowspan="5">Liver</td><td>TF</td><td>0.855</td><td>0.800</td><td>0.524</td><td>0.873</td></tr><tr><td>w/ Matcher</td><td>0.879</td><td>0.809</td><td>0.544</td><td>0.866</td></tr><tr><td>w/ Dice</td><td>0.879</td><td>0.814</td><td>0.544</td><td>0.871</td></tr><tr class="ours"><td>Ours</td><td>0.879</td><td>0.810</td><td>0.544</td><td>0.874</td></tr><tr><td>Ours + cls</td><td>0.879</td><td>0.810</td><td>0.544</td><td>0.871</td></tr>
</tbody></table></div>

The extra classification-head experiment was not consistently helpful: `Ours + cls` slightly decreases the Mammary and Thyroid scores, while Liver remains nearly unchanged.

### Case study

<figure class="blog-figure">
<img src="{{ '/images/blog/curdnet/generated-case.png' | relative_url }}" alt="Example of a generated ultrasound report">
<figcaption>An example comparison between the reference report, a vanilla Transformer, and CURDNet.</figcaption>
</figure>

## <span id="conclusion">Conclusion</span>

Diversity-aware sampling and cross-modal matching complement each other: one changes what the model sees, while the other changes how it checks image-text alignment. The main limitation is that EchoDice uses organ labels, so its generalization to unlabeled or unseen organs is still an open question. The study is also a research prototype, not a clinical decision-making system.

## <span id="links">Links</span>
More details regarding this project can be found on:
- [Technical report (PDF)]({{ '/files/anonymous-submission-latex-2026-curdnet.pdf' | relative_url }})
- [Code](https://github.com/chenzhwsysu57/Ultrasound-Report-Generation)
- [Dataset](https://lijunrio.github.io/Ultrasound-Report-Generation/)
