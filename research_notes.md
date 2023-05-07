# Solving MovieLens with neural networks

## About

This is a preliminary study of current popular approaches used in recommendation systems for learning embeddings of users/items in recommendation systems.

The problem statement, provided by internship selection process, is following: "Use neural network approaches to construct embeddings of users and films, so that embeddings of users could be used for searching for similar films and recommend them for users". This precisly means that end-goal is not to develop end2end recommendation system, but a part of recommendation pipeline responsible for learning user/item representations. Still, considering that these vectors end up being used for recommendations, we have to hold this in mind and study what is industry up to.

## Common approaches

When talking about recommendation systems, there are 3 common ways to solve them.

1. Collaborative filtering (user/item interactions)
2. Content-based recommendations (what is user/what is item?)
3. Hybrid systems (1 + 2)

First one operates on the knowledge of statistical correlations between users and movies. Basic idea is that users can be defined similar by the similarity of their movie preferences, and the opposite is also true. This approach doesn't consider inner representations/features of movies/users, only their coocurences. The most common approach for this one is to use Matrix Factorization.

Content-based filtering tries to deduce user similarity based on the features of the movies they like. For example, such represenations could be extracted through NLP over language features of movies. It really depends on the kind of data you are dealing, and hypothesis of conditioning on certain kind of data.

Last one combines approaches of previous ones in certain way. The main point of combining them is that collabarative approaches usually suffer from cold start, when there is no interaction history to use for new user/item. Thats where content features can be used for recommending.

## Some cool neural network methods used in recs

We will omit ML methods like tf-idf + some sort of regression, SVD, KNN, etc. and go straight for neural approaches. One might argue where do neural approaches start - when we use AD framework and gradient descent to solve optimization problem (like in ALS) or when we actually use some sort of neural network components, resembling layer-like structure. I will favor mathematical definition, as it allows more flexibility (and I want to use ALS baseline 😋). 

### Baselines

This models might be pretty much good enough and they are easy to set up.

**ALS** - Alternating Least Squares is a modification of MF methods. All MF simulate matrix decomposition through optimizing two feature matrices of users and items. Simlilarity of them is determined through dot product, and parameters of matrices are updated via GD on regression loss function. ALS is pretty scalable, as it relies on sparse data structures for representing values (which is crucial for rec-sys, as data is pretty much very sparse). - https://arxiv.org/pdf/1708.05024.pdf

**Factorization Machines** - recom. task -> regression. It's a hybrid approach, as it relies on dataset as a concatenation of one-hot encodings of users and items + information about their interactions. Target is feedback between user and item. Some item level features can be added also. Relies on scalar dot product as a simlilarity metric. These days commonly used as a component of bigger architectures - https://d2l.ai/chapter_recommender-systems/fm.html

### For cool kids

**NCF** (Neural Collaborative Filtering) [1]. Introduced in 2017 paper, this method replaces dot product in Matrix Factorization method with neural networks layers. Embedding layers are used for both user and item to learn representations of one-hot-encoded vectors that neural network will be using. In fact, this approach is very much inspired by Siamse Neural Networks in it's spirit. It's modification from the same paper, **NeuMF** leverages a more complex architecture by indroducing GMF layer, but the approach is still pretty much the same. The main feature of this approach is that it targets to predict implicit feedback expressed as binary interaction, which allows probabalistic loss.

Theoretical performance on MovieLens: HR@10 ~ 0.73, NDCG@10 ~ 0.45, better then ALS and KNN methods (statement from paper).

*Note: this approach is not that common on practice, **DSSM** is a much more scalable approach.

**DeepFM** (2017) - Deep Factorization Machines - combine FM and deep neaural network. Idea is to use both low and high order feature representations for predicting target interaction. Theoretically better convergance then FM and better quality. - https://d2l.ai/chapter_recommender-systems/deepfm.html

**DLRM** (Facebook, 2019) - carefully engineered SOTA approach from Facebook, combining effectivly feature extraction through MLP for continous features and embedding layers for categorials. THeir concatination is passed into FM, that will produce vector interaction, which finally pass through MLP. It not only produces great results, but can be scaled effectively, as different parts of architecture rely on different kind of resources. It also can be used as an architecture baseline for further exploration and comparison.
https://github.com/facebookresearch/dlrm

Bonus: **Variational AutoEncoders in Recommendations** - cool idea (read later if time left)
https://www.kaggle.com/code/alirezanematolahy/recommender-system-using-auto-encoders
https://arxiv.org/pdf/1802.05814.pdf


## Other References

1. Overview of approaches Pt.1 - https://habr.com/ru/companies/prequel/articles/567648/
2. Overview of approaches Pt.2 - https://habr.com/ru/companies/prequel/articles/573880/
3. Study of metrics - https://habr.com/ru/companies/otus/articles/732842/




