---
title: "从Code Agent的演变看待harness工程"
date: 2026-06-03T22:49:12+08:00
draft: false
tags: ["code agent", "harness"]
categories: []
summary: "从 PI Agent 和 cc-connect 的体验出发，重新审视 Agent = model + harness 这个等式——harness 工程应该被认真对待，它不止为模型设计，也可以为人而设计，愿每个人都能打造自己的 Jarvis。"
---

## 怪象：停不下来的造轮子

最近有个现象让我很困惑：`Claude Code` 明明已经足够好用了，开源社区却还在不断冒出新的 Code Agent——`Kode`、`OpenCode`、`Codex`，以及各大模型厂商自研的方案。更意外的是 `PI Agent`，一个看起来非常简单的 micro code agent，竟然在短时间内走红了。

我跟朋友吐槽：用了这么多，`Claude Code` 还是最靠谱的那个，大家到底在造什么轮子？

我当时没有答案，直到想起两件事。

## CC-Connect：它好像真的有用

第一件，是 `cc-connect`。

起初我对它不以为意。改个配置文件而已，对于常年折腾终端工具的我，这能有什么价值？

但后来我开始同时使用 `openclaw`、`hermes`、`codex` 等多款工具，画风就变了。版本更新要改配置，切环境要改配置，偶尔一个不起眼的 JSON 格式错误也要花几分钟定位。这些琐碎操作单个看都不值一提，累积起来却成了持续的摩擦。

我突然看懂了 `cc-connect` 在解决什么问题。现在我的每个环境都装着它——不是因为它做了什么惊天动地的事，而是因为它消除了一种隐形成本。

有些工具的价值，只会在特定的场景体现。

## PI Agent：Vim 式的自由

第二件，是 `PI Agent`。

我花了十来分钟，借助 `Claude Code` 写了一个自定义网关插件，把它跑了起来。然后我注意到一种微妙的差异——它和 `Claude Code` 的关系，很像 Vim 和 VS Code。

为了驯服 Vim，我当年啃了半个月的《Practical Vim》，才勉强理清那些配置逻辑。投入巨大，但回报是一种特殊的掌控感：你的编辑器完完全全属于你。

`PI` 比 Vim 简单得多。它的 extension 机制就是 Vim 插件体系的微缩版——你需要什么，就写什么。没有沉重的 system prompt，没有你不关心的上下文。只需要 vibe, vibe, vibe，就能构建一套你专属的工作流。

> 它快。它轻。它只和你的习惯有关。

既然我已经习惯了编写 `CLAUDE.md`，那编写自己的插件不过是同一件事的延伸。它承载的所有上下文，都是我的。如果有一天，这些上下文积累了我全部的知识和偏好，它或许就成了另一个我。

这种感觉很奇妙，但不是玄学——它在做的，就是专属于我的 harness。

这两件小事指向了同一个方向，让我开始重新审视一个简单的等式。

---

<div class="callout">
  <span class="callout-label">核心等式</span>
  <p><strong>Agent = model + harness</strong></p>
</div>

模型正在百花齐放。LLM 本质上是一个概率黑盒，不同厂商调教出的模型各有偏向，不同 temperature 下同一个 prompt 也走向不同岔路。搭配上不同的 harness，最终的效果必然千差万别。

这个等式本身没什么新鲜的。真正让我意外的，是大多数人怎么看它。

## 被低估的 harness

谈起 harness，多数人的反应是——"不过是一堆文字的排列组合"。

如果真是这样，为什么 `Superpowers` 这套 prompt 就是比别人的 skill 好用？为什么 `openclaw` 和 `hermes` 能做到 `Claude` 原生做不了的事？为什么越来越多资深开发者开始认真投入这个方向？

差别就在设计。

软件工程中，设计模式决定了项目的可维护性、扩展性和稳定性。harness 同样如此——哪怕只是调整 prompt 的拼接顺序，也可能在某次推理中改变模型的输出质量，进而影响你完成同一件事的时间成本。

harness 应该被放在和软件工程同等的地位上被认真对待。

这个结论听起来有点重，但接下来的发现让我更加确信。

## 打造每个人的 Jarvis

最近我重新跑了一遍 [`learn-claude-code`](https://github.com/shareAI-lab/learn-claude-code.git)，把模型切到 `claude-sonnet-4.6`。结果让我意外：这个最简单的 Agent 架构，在我预设的场景里，效果甚至优于 `Claude Code` 本身。

一个精简架构，就能匹敌复杂框架的表现。这意味着我们可能根本不需要那么重的东西。harness 本身就会随着模型更迭而持续演化——以前是软件迭代，以后是 harness 迭代。

更进一步——harness 不止为模型设计，也为**人**而设计。

每个人的审美和偏好曲线都不一样。一个 LLM 如果能完美拟合你的那条曲线，它就真正成为了你的 Jarvis。它不必是世界上最全知的 AI，但它会是，最懂你的那个。

<div class="key-point">
  <p>愿每个人都能拥有自己的 Jarvis。</p>
</div>
