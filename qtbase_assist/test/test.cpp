#include <QCoreApplication>
#include <QThreadPool>
#include <QDebug>

class MyTask : public QRunnable {
public:
    void run() override {
        qDebug() << "Running task in thread:" << QThread::currentThread();
    }
};

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QThreadPool *pool = QThreadPool::globalInstance();
    pool->setMaxThreadCount(4); // 设置最大线程数

    for (int i = 0; i < 10; ++i) {
        MyTask *task = new MyTask();
        pool->start(task); // 提交任务给线程池
    }

    return 0;
}


