function [accuracy, inliner, total] = applyRansac(original,query)
% APPLYRANSAC computes ransac match accuracy of two descriptors.
%
%
% Ilhan Adiyaman
% 2015700000
% 21.12.2015
%


d1 = original{2};
f1 = original{1};

d2 = query{2};
f2 = query{1};


[matches, scores] = vl_ubcmatch(d1,d2) ;

numMatches = size(matches,2) ;

X1 = f1(1:2,matches(1,:)) ; X1(3,:) = 1 ;
X2 = f2(1:2,matches(2,:)) ; X2(3,:) = 1 ;

% --------------------------------------------------------------------
%                                         RANSAC with homography model
% --------------------------------------------------------------------
if numMatches > 0
    clear H score ok ;
    for t = 1:100
        % estimate homograpyh
        subset = vl_colsubset(1:numMatches, 4) ;
        A = [] ;
        for i = subset
            A = cat(1, A, kron(X1(:,i)', vl_hat(X2(:,i)))) ;
        end
        [U,S,V] = svd(A) ;
        H{t} = reshape(V(:,9),3,3) ;
        
        % score homography
        X2_ = H{t} * X1 ;
        du = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:) ;
        dv = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:) ;
        ok{t} = (du.*du + dv.*dv) < 6*6 ;
        score(t) = sum(ok{t}) ;
    end
    
    [score, best] = max(score) ;
    H = H{best} ;
    ok = ok{best};
    
    accuracy = 100*sum(ok)/numMatches;
    total = numMatches;
    inliner = score;
else
    accuracy = 0;
    total = 0;
    inliner = 0;
end