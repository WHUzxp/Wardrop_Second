%��������㷨
function possiablePaths = findPath(Graph, partialPath, destination, partialWeight)
% findPath����������������п��ܵĴ�partialPath������destination��·������Щ·���в�������·
% Graph: ·��ͼ���������0��ʾ���ڵ�֮��ֱ����ͨ������ֵ��Ϊ·��Ȩֵ
% partialPath: ������·�������partialPath��һ��������ʾ���������ʼ��
% destination: Ŀ��ڵ�
% partialWeight: partialPath��Ȩֵ����partialPathΪһ����ʱ��partialWeightΪ0
pathLength = length(partialPath);
lastNode = partialPath(pathLength); %�õ����һ���ڵ�
nextNodes = find(0<Graph(lastNode,:) & Graph(lastNode,:)<inf); %����Graphͼ�õ����һ���ڵ����һ���ڵ�
GLength = length(Graph);
possiablePaths = [];
if lastNode == destination
% ���lastNode��Ŀ��ڵ���ȣ���˵��partialPath���Ǵ��������Ŀ��ڵ��·�������ֻ����һ����ֱ�ӷ���
possiablePaths = partialPath;
possiablePaths(GLength + 1) = partialWeight;
return;
elseif length( find( partialPath == destination ) ) ~= 0
return;
end
%nextNodes�е���һ������0,����Ϊ����nextNodes(i)ȥ�����Ƚ��丳ֵΪ0
for i=1:length(nextNodes)
if destination == nextNodes(i)
  %���·��
  tmpPath = cat(2, partialPath, destination);      %���ӳ�һ��������·��
  tmpPath(GLength + 1) = partialWeight + Graph(lastNode, destination); %�ӳ����鳤����GLength+1, ���һ��Ԫ�����ڴ�Ÿ�·������·��
  possiablePaths( length(possiablePaths) + 1 , : ) = tmpPath;
  nextNodes(i) = 0;
elseif length( find( partialPath == nextNodes(i) ) ) ~= 0
  nextNodes(i) = 0;
end
end
nextNodes = nextNodes(nextNodes ~= 0); %��nextNodes��Ϊ0��ֵȥ������Ϊ��һ���ڵ�����Ѿ�����������������Ŀ��ڵ�
for i=1:length(nextNodes)
tmpPath = cat(2, partialPath, nextNodes(i));
tmpPsbPaths = findPath(Graph, tmpPath, destination, partialWeight + Graph(lastNode, nextNodes(i)));
possiablePaths = cat(1, possiablePaths, tmpPsbPaths);
end